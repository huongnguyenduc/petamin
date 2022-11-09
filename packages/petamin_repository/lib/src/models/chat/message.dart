import 'package:equatable/equatable.dart';

class Message extends Equatable {
  Message({
    this.time,
    this.status,
    this.message,
    this.type,
    this.isMe,
  });

  DateTime? time;
  bool? status;
  String? message;
  String? type;
  bool? isMe;

  // Empty Message
  Message.empty() : this(message: '', isMe: false);

  @override
  List<Object?> get props => [time, status, message, type, isMe];
}
