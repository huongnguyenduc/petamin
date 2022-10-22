import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_detail_state.dart';

class ChatDetailCubit extends Cubit<ChatDetailState> {
  ChatDetailCubit() : super(ChatDetailState());

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
}
