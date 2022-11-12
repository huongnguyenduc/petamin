part of 'chat_detail_cubit.dart';

// Chat Detail Status
enum ChatDetailStatus { initial, loading, loaded, error }

class ChatDetailState extends Equatable {
  ChatDetailState({this.messages = const [], this.chatMessage = "",this.status = ChatDetailStatus.initial, this.partner});

  final List<Message> messages;
  final String chatMessage;
  final ChatDetailStatus status;
  Profile? partner = Profile.empty();
  @override
  List<Object?> get props => [messages, chatMessage, status, partner];
 
  ChatDetailState copyWith({
    List<Message>? messages,
    String? chatMessage,
    ChatDetailStatus? status,
    Profile? partner,
  }) {
    return ChatDetailState(
      messages: messages ?? this.messages,
      chatMessage: chatMessage ?? this.chatMessage,
      status: status ?? this.status,
      partner: partner ?? this.partner,
    );
  }
}

class LoadingFireVideoCallState extends ChatDetailState {}

class SuccessFireVideoCallState extends ChatDetailState {
  final CallModel callModel;

  SuccessFireVideoCallState({required this.callModel});
}

class ErrorFireVideoCallState extends ChatDetailState {
  final String message;

  ErrorFireVideoCallState(this.message);
}

class ErrorPostCallToFirestoreState extends ChatDetailState {
  final String message;

  ErrorPostCallToFirestoreState(this.message);
}

class ErrorUpdateUserBusyStatus extends ChatDetailState {
  final String message;

  ErrorUpdateUserBusyStatus(this.message);
}

class ErrorSendNotification extends ChatDetailState {
  final String message;

  ErrorSendNotification(this.message);
}
