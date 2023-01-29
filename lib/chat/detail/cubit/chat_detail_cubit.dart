import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:Petamin/app/cubit/socket_io/modal.dart';
import 'package:Petamin/app/cubit/socket_io/socket_io_cubit.dart';
import 'package:Petamin/data/api/call_api.dart';
import 'package:Petamin/data/models/call_model.dart';
import 'package:Petamin/data/models/fcm_payload_model.dart';
import 'package:Petamin/shared/constants.dart';
import 'package:Petamin/shared/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petamin_repository/petamin_repository.dart';

part 'chat_detail_state.dart';

class ChatDetailCubit extends Cubit<ChatDetailState> {
  ChatDetailCubit(this.conversationId, this._petaminRepository, this._socketIoCubit) : super(ChatDetailState()) {
    initMessages();
  }

  final String conversationId;
  final ScrollController scrollController = new ScrollController();
  final PetaminRepository _petaminRepository;
  final SocketIoCubit _socketIoCubit;
  Timer? _debounce;
  late StreamSubscription<Message> messageSubscription;
  late StreamSubscription<List<String>> onlineSubscription;
  late StreamSubscription<TypingMessage> typingSubscription;

  void scrollToBottom() {
    scrollController.animateTo(
      // scrollController.position.maxScrollExtent + 75.0,
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void initMessages() async {
    try {
      EasyLoading.show();
      print('initMessages 1');
      emit(state.copyWith(status: ChatDetailStatus.loading));
      print('initMessages 2');
      await getUserDetailConversation();
      print('initMessages 3');
      await getMessages();
      print('initMessages 4');

      print('initMessages');
      print('socketIO state from chat detail: ${_socketIoCubit.state}');
      if (_socketIoCubit.state is SocketIoConnected) {
        print('Socket connected online from chat detail');
        updateOnline((_socketIoCubit.state as SocketIoConnected).onlineUsers);
      }
      listenToSocket();
    } catch (e) {
      emit(state.copyWith(status: ChatDetailStatus.error));
    } finally {
      EasyLoading.dismiss();
    }
  }

  void sendMessage() {
    if (state.chatMessage.isNotEmpty) {
      _socketIoCubit.sendMessage(message: state.chatMessage, conversationId: conversationId);
      _socketIoCubit.sendTyping(conversationId: conversationId, isTyping: false);
      emit(state.copyWith(isSendingTyping: false, chatMessage: ''));
    }
  }

  Future<void> getUserDetailConversation() async {
    try {
      final info = await _petaminRepository.getUserDetailConversation(conversationId: conversationId);
      emit(state.copyWith(status: ChatDetailStatus.loaded, partner: info.partner));
    } catch (e) {
      emit(state.copyWith(status: ChatDetailStatus.error));
    }
  }

  Future<void> getMessages() async {
    try {
      final messages = await _petaminRepository.getChatMessages(conversationId);
      scrollToBottom();
      emit(state.copyWith(status: ChatDetailStatus.loaded, messages: messages));
    } catch (e) {
      emit(state.copyWith(status: ChatDetailStatus.error));
    }
  }

  void listenToSocket() {
    print('listeningggg');
    // Receive typing
    typingSubscription = _socketIoCubit.typingStream.stream.listen((typingMessage) {
      print('Listen socket typing from chat detail cubit');
      updateTyping(typingMessage);
      // typingSubscription.cancel();
    });
    // Receive message
    messageSubscription = _socketIoCubit.messageStream.stream.listen((message) {
      if (message.conversationId?.compareTo(conversationId) == 0) {
        print('Listen socket message from chat detail cubit');
        addMessage(message);
        scrollToBottom();
        // messageSubscription.cancel();
      }
    });

    // Receive online
    onlineSubscription = _socketIoCubit.onlineStream.stream.listen((onlineUsers) {
      print('Update Socket Online users from chet detail: $onlineUsers');
      updateOnline(onlineUsers);
      // onlineSubscription.cancel();
    });

    print('listeneddd');
  }

  void addMessage(Message message) {
    if (isClosed) return;

    emit(state.copyWith(messages: [message, ...state.messages]));

    // Remove typing message if exist
  }

  void updateOnline(List<String> onlineUsers) {
    if (isClosed) return;
    final partner =
        onlineUsers.firstWhere((element) => element.compareTo(state.partner?.userId ?? '') == 0, orElse: () => '');
    if (partner.isNotEmpty && state.isPartnerOnline == false) {
      emit(state.copyWith(isPartnerOnline: true));
    } else if (state.isPartnerOnline) {
      emit(state.copyWith(isPartnerOnline: false));
    }
  }

  void updateTyping(TypingMessage typingMessage) {
    if (isClosed) {
      print('typing isClosed');
      return;
    }
    if (typingMessage.conversationId.compareTo(conversationId) != 0) return;
    bool isTyping = typingMessage.isTyping;
    if (state.isTyping != isTyping) {
      emit(state.copyWith(isTyping: isTyping));

      // Check if last message is typing message
      bool hasTypingMessage =
          state.messages.firstWhere((element) => element.type == 'TYPING', orElse: () => Message()).id != null;

      if (isTyping && !hasTypingMessage) {
        emit(state.copyWith(messages: [Message(type: 'TYPING', isMe: false, id: 'Meow'), ...state.messages]));
      } else if (!isTyping && hasTypingMessage) {
        // remove typing message if exist
        List<Message> messages = state.messages.map((e) => e).toList();
        messages.removeWhere((element) => element.type == 'TYPING');
        emit(state.copyWith(messages: messages));
      }
    }
  }

  ScrollController getScrollController() {
    return scrollController;
  }

  void typeMessage(String message) {
    if (!state.isSendingTyping) {
      emit(state.copyWith(isSendingTyping: true));
      _socketIoCubit.sendTyping(conversationId: conversationId, isTyping: message.isNotEmpty);
      // add debounce to typing message to prevent spamming socket
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 2500), () {
        // cancel typing
        _socketIoCubit.sendTyping(conversationId: conversationId, isTyping: false);
        emit(state.copyWith(isSendingTyping: false));
      });
    }

    emit(state.copyWith(chatMessage: message));
  }

  @override
  Future<void> close() async {
    _debounce?.cancel();
    await typingSubscription?.cancel();
    await messageSubscription?.cancel();
    await onlineSubscription?.cancel();
    print('Chat detail cubit closed');
    super.close();
  }

  void selectMultipleImages() async {
    List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();

    if (pickedFiles != null) {
      emit(state.copyWith(status: ChatDetailStatus.loading));
      print('Picked files: $pickedFiles');
      try {
        final List<File> files = pickedFiles.map((e) => File(e.path)).toList();
        print('Image files: $files');
        final String encodeImagesJson = await _petaminRepository.uploadMultipleFiles(files: files);
        print('encodeImagesJson: $encodeImagesJson');
        _socketIoCubit.sendMessage(conversationId: conversationId, message: encodeImagesJson, type: 'IMAGE');
        emit(state.copyWith(status: ChatDetailStatus.loaded));
      } catch (e) {
        emit(state.copyWith(status: ChatDetailStatus.error));
        print('Error upload image: $e');
      }
    }
  }

  final _callApi = CallApi();
  bool fireCallLoading = false;

  Future<void> fireVideoCall({required CallModel callModel}) async {
    fireCallLoading = true;
    // emit(LoadingFireVideoCallState());
    //1-generate call token
    String channelName = 'channel_${UniqueKey().hashCode.toString()}';

    _petaminRepository.getAgoraToken(channelName).then((value) {
      callModel.token = value;
      callModel.channelName = channelName;
      //2-post call in Firebase
      postCallToFirestore(callModel: callModel);
    }).catchError((onError) {
      fireCallLoading = false;
      //For test
      callModel.token =
          '006192a26c66db7459284748c71ad2d3570IAATc2TswWAZULeSR0o/HiCOcWuel+WCD2BI6UOJMg0acto7UjcAAAAAIgAC6/OUNut6YwQAAQDGp3ljAgDGp3ljAwDGp3ljBADGp3lj';
      //agoraTestToken;
      callModel.channelName = agoraTestChannelName;
      postCallToFirestore(callModel: callModel);
      emit(state.copyWith(callVideoStatus: CallVideoStatus.ErrorFireVideoCallState, errorMessage: onError.toString()));
    });
  }

  void postCallToFirestore({required CallModel callModel}) {
    _callApi.postCallToFirestore(callModel: callModel).then((value) {
      //3-update user busy status in Firebase
      // _callApi
      //     .updateUserBusyStatusFirestore(callModel: callModel, busy: true)
      //     .then((value) {
      fireCallLoading = false;
      //4-send notification to receiver
      sendNotificationForIncomingCall(callModel: callModel);
      // }).catchError((onError) {
      //   fireCallLoading = false;
      //   emit(ErrorUpdateUserBusyStatus(onError.toString()));
      // });
    }).catchError((onError) {
      fireCallLoading = false;
      emit(state.copyWith(
          callVideoStatus: CallVideoStatus.ErrorPostCallToFirestoreState, errorMessage: onError.toString()));
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
          debugPrint('SendNotifySuccess ${value.data.toString()}');
          emit(state.copyWith(callVideoStatus: CallVideoStatus.SuccessFireVideoCallState, callModel: callModel));
        }).catchError((onError) {
          debugPrint('Error when send Notify: $onError');
          fireCallLoading = false;
          emit(
              state.copyWith(callVideoStatus: CallVideoStatus.ErrorSendNotification, errorMessage: onError.toString()));
        });
      }
    }).catchError((onError) {
      debugPrint('Error when get user token: $onError');
      fireCallLoading = false;
      emit(state.copyWith(callVideoStatus: CallVideoStatus.ErrorSendNotification, errorMessage: onError.toString()));
    });
  }
}
