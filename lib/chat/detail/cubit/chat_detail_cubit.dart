import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

part 'chat_detail_state.dart';

class ChatDetailCubit extends Cubit<ChatDetailState> {
  ChatDetailCubit(this.conversationId) : super(ChatDetailState());
  late IO.Socket socket;
  final conversationId;

  void initSocket() {
    socket = IO.io('http://192.168.3.158:3000', <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
      'extraHeaders': {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imh1eUBjb2RlbGlnaHQuY28iLCJ1c2VySWQiOiIwYmQ5NThlNi05YjU5LTQzMDgtODI4MC0zM2RkY2JhYzRhZjEiLCJpYXQiOjE2Njc3MjA5NTcsImV4cCI6MTY2ODMyNTc1N30.N1aqAOa-rxXVLVgLMDQuKzKksD5kP1jViYZw5C1EJxw'
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
        ChatMessage(
            data: data["message"],
            messageType: ChatMessageType.text,
            messageStatus: MessageStatus.not_view,
            isSender: false,
            time: '19:15')
      ], chatMessage: ''));
    });
  }

  void sendMessage() {
    print("send message");
    print("message: ${state.chatMessage}");
    if (state.chatMessage.isNotEmpty) {
      socket.emit("messages", {"conversationId": conversationId, "message": state.chatMessage});
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
}
