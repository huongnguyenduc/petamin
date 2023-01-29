import 'package:equatable/equatable.dart';

class LastMessage extends Equatable {
  String message;
  bool isMe;
  DateTime time;
  String type;
  String id;

  LastMessage({required this.message, required this.isMe, required this.time, required this.type, required this.id});

  // Empty LastMessage
  LastMessage.empty() : this(message: '', isMe: false, time: DateTime.now(), type: '', id: '');

  @override
  List<Object?> get props => [message, isMe, time, type, id];
}
