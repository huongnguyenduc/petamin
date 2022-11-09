import 'dart:convert';

import 'package:Petamin/data/api/call_api.dart';
import 'package:Petamin/data/models/call_model.dart';
import 'package:Petamin/data/models/fcm_payload_model.dart';
import 'package:Petamin/shared/constants.dart';
import 'package:Petamin/shared/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:petamin_repository/petamin_repository.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

part 'chat_detail_state.dart';

class ChatDetailCubit extends Cubit<ChatDetailState> {
  ChatDetailCubit(this.conversationId, this.accessToken, this._petaminRepository) : super(ChatDetailState());
  late IO.Socket socket;
  final conversationId;
  final accessToken;
  final ScrollController scrollController = new ScrollController();
  final PetaminRepository _petaminRepository;

  void initSocket() {
    final apiLink = dotenv.env['API_LINK'];
    socket = IO.io(apiLink, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
      'extraHeaders': {
        'Authorization': 'Bearer $accessToken',
      },
    });

    socket.connect();
    socket.onConnect((_) {
      print('Connection established');
    });
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));
    socket.on('message-received', (data) {
      print(data);
      emit(state.copyWith(messages: [
        ...state.messages,
        Message(
            message: data["message"],
            type: data["type"],
            status: data["status"],
            isMe: false,
            time: DateTime.tryParse(data["createdAt"]))
      ], chatMessage: ''));
      scrollToBottom();
    });
  }

  void scrollToBottom() {
    scrollController.animateTo(
      // scrollController.position.maxScrollExtent + 75.0,
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void sendMessage() {
    if (state.chatMessage.isNotEmpty) {
      socket.emit("messages", {"conversationId": conversationId, "message": state.chatMessage, "type": "TEXT"});
      emit(state.copyWith(messages: [
        ...state.messages,
        Message(message: state.chatMessage, type: "TEXT", status: false, isMe: true, time: DateTime.now())
      ], chatMessage: ''));
      scrollToBottom();
    }
  }

  Future<void> getMessages() async {
    try {
      emit(state.copyWith(status: ChatDetailStatus.loading));
      final messages = await _petaminRepository.getChatMessages(conversationId);
      scrollToBottom();
      emit(state.copyWith(status: ChatDetailStatus.loaded, messages: messages));
    } catch (e) {
      emit(state.copyWith(status: ChatDetailStatus.error));
    }
  }

  ScrollController getScrollController() {
    return scrollController;
  }

  void typeMessage(String message) {
    emit(state.copyWith(chatMessage: message));
  }

  final _callApi = CallApi();
  bool fireCallLoading = false;

  Future<void> fireVideoCall({required CallModel callModel}) async {
    fireCallLoading = true;
    emit(LoadingFireVideoCallState());
    //1-generate call token
    Map<String, dynamic> queryMap = {
      'channelName': 'channel_${UniqueKey().hashCode.toString()}',
      'uid': callModel.callerId,
    };
    _callApi.generateCallToken(queryMap: queryMap).then((value) {
      callModel.token = value['token'];
      callModel.channelName = value['channel_name'];
      //2-post call in Firebase
      postCallToFirestore(callModel: callModel);
    }).catchError((onError) {
      fireCallLoading = false;
      //For test
      callModel.token = agoraTestToken;
      callModel.channelName = agoraTestChannelName;
      postCallToFirestore(callModel: callModel);
      emit(ErrorFireVideoCallState(onError.toString()));
    });
  }

  void postCallToFirestore({required CallModel callModel}) {
    _callApi.postCallToFirestore(callModel: callModel).then((value) {
      //3-update user busy status in Firebase
      _callApi.updateUserBusyStatusFirestore(callModel: callModel, busy: true).then((value) {
        fireCallLoading = false;
        //4-send notification to receiver
        sendNotificationForIncomingCall(callModel: callModel);
      }).catchError((onError) {
        fireCallLoading = false;
        emit(ErrorUpdateUserBusyStatus(onError.toString()));
      });
    }).catchError((onError) {
      fireCallLoading = false;
      emit(ErrorPostCallToFirestoreState(onError.toString()));
    });
  }

  void sendNotificationForIncomingCall({required CallModel callModel}) {
    FirebaseFirestore.instance.collection(tokensCollection).doc(callModel.receiverId).get().then((value) {
      if (value.exists) {
        Map<String, dynamic> bodyMap = {'type': 'call', 'title': 'New call', 'body': jsonEncode(callModel.toMap())};
        FcmPayloadModel fcmSendData = FcmPayloadModel(to: value.data()!['token'], data: bodyMap);
        debugPrint('SendNotify');
        DioHelper.postData(
          data: fcmSendData.toMap(),
          baseUrl: 'https://fcm.googleapis.com/',
          endPoint: 'fcm/send',
        ).then((value) {
          debugPrint('SendNotifySuccess');
          debugPrint('SendNotifySuccess');
          debugPrint('SendNotifySuccess');
          debugPrint('SendNotifySuccess ${value.data.toString()}');
          emit(SuccessFireVideoCallState(callModel: callModel));
        }).catchError((onError) {
          debugPrint('Error when send Notify: $onError');
          fireCallLoading = false;
          emit(ErrorSendNotification(onError.toString()));
        });
      }
    }).catchError((onError) {
      debugPrint('Error when get user token: $onError');
      fireCallLoading = false;
      emit(ErrorSendNotification(onError.toString()));
    });
  }
}
