part of 'chat_detail_cubit.dart';

class ChatDetailState extends Equatable {
  const ChatDetailState(
      {this.messages = demoChatMessage, this.chatMessage = ""});
  final List<ChatMessage> messages;
  final String chatMessage;
  @override
  List<Object> get props => [messages, chatMessage];

  ChatDetailState copyWith({
    List<ChatMessage>? messages,
    String? chatMessage,
  }) {
    return ChatDetailState(
      messages: messages ?? this.messages,
      chatMessage: chatMessage ?? this.chatMessage,
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

enum ChatMessageType { text, image, transfer }

enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String data;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;
  final String time;

  const ChatMessage({
    this.data = '',
    required this.messageType,
    required this.messageStatus,
    required this.isSender,
    required this.time,
  });
}

const List<ChatMessage> demoChatMessage = <ChatMessage>[
  ChatMessage(
    data: "Hey man!\nI am comming...10 min",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
    time: '19:15',
  ),
  ChatMessage(
    data: "Okey",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: true,
    time: '19:15',
  ),
  ChatMessage(
    messageType: ChatMessageType.image,
    messageStatus: MessageStatus.viewed,
    isSender: false,
    time: 'abc',
  ),
  ChatMessage(
    data: "New home for kids ^^",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
    time: '12:16',
  ),
  ChatMessage(
    data: "I love them",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
    time: '12:16',
  ),
  ChatMessage(
    data: "Transfer him to me, pls",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
    time: '12:16',
  ),
];
