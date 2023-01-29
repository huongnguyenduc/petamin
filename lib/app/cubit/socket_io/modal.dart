import 'package:equatable/equatable.dart';

class TypingMessage extends Equatable {
  final String conversationId;
  final bool isTyping;

  TypingMessage({required this.conversationId, required this.isTyping});

  // Empty Typing Message
  TypingMessage.empty()
      : conversationId = '',
        isTyping = false;

  @override
  List<Object> get props => [conversationId, isTyping];
}
