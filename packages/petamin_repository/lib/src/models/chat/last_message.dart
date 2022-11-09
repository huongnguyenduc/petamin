import 'package:equatable/equatable.dart';

class LastMessage extends Equatable {
  String message;
  bool isSender;

  LastMessage({
    required this.message,
    required this.isSender,
  });

  // Empty LastMessage
  LastMessage.empty() : this(message: '', isSender: false);

  @override
  List<Object?> get props => [message, isSender];
}
