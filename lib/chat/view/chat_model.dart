enum ChatMessageType { text, image, transfer }

enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String data;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;
  final String time;

  ChatMessage({
    this.data = '',
    required this.messageType,
    required this.messageStatus,
    required this.isSender,
    required this.time,
  });
}

List demoChatMessage = [
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
