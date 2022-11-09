import 'package:equatable/equatable.dart';

class LastMessage extends Equatable {
  String message;
  bool isMe;

  LastMessage({
    required this.message,
    required this.isMe,
  });

  // Empty LastMessage
  LastMessage.empty() : this(message: '', isMe: false);

  @override
  List<Object?> get props => [message, isMe];
}
