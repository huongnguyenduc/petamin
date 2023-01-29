import 'package:equatable/equatable.dart';

class Message extends Equatable {
  const Message({
    this.time,
    this.message,
    this.type,
    this.isMe,
    this.id,
    this.conversationId,
  });

  final DateTime? time;
  final String? message;
  final String? type;
  final bool? isMe;
  final String? id;
  final String? conversationId;

  // Empty Message
  Message.empty() : this(message: '', isMe: false, id: '', type: '', conversationId: '');

  @override
  List<Object?> get props => [time, message, type, isMe, id, conversationId];
}
