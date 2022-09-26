import 'dart:convert';

import 'package:Petamin/data/api/call_api.dart';
import 'package:Petamin/data/models/call_model.dart';
import 'package:Petamin/data/models/fcm_payload_model.dart';
import 'package:Petamin/shared/constants.dart';
import 'package:Petamin/shared/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_detail_state.dart';

class ChatDetailCubit extends Cubit<ChatDetailState> {
  ChatDetailCubit() : super(ChatDetailState());
    static ChatDetailCubit get(context) => BlocProvider.of(context);
  void sendMessage() {
    print("send message");
    print("message: ${state.chatMessage}");
    if (state.chatMessage.isNotEmpty) {
      emit(state.copyWith(messages: [
        ...state.messages,
        ChatMessage(
            data: state.chatMessage,
            messageType: ChatMessageType.text,
            messageStatus: MessageStatus.not_view,
            isSender: true,
            time: '19:15')
      ], chatMessage: ''));
    }
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
      _callApi
          .updateUserBusyStatusFirestore(callModel: callModel, busy: true)
          .then((value) {
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
    FirebaseFirestore.instance
        .collection(tokensCollection)
        .doc(callModel.receiverId)
        .get()
        .then((value) {
      if (value.exists) {
        Map<String, dynamic> bodyMap = {
          'type': 'call',
          'title': 'New call',
          'body': jsonEncode(callModel.toMap())
        };
        FcmPayloadModel fcmSendData =
            FcmPayloadModel(to: value.data()!['token'], data: bodyMap);
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
