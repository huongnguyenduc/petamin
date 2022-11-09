import 'package:json_annotation/json_annotation.dart';

part 'chat_last_message.g.dart';

@JsonSerializable()
class ChatLastMessage {
  ChatLastMessage({
    required this.id,
    required this.status,
    required this.message,
    required this.userId,
    required this.conversationId,
  });

  String id;
  bool status;
  String message;
  String userId;
  String conversationId;

  factory ChatLastMessage.fromJson(Map<String, dynamic> json) => _$ChatLastMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatLastMessageToJson(this);
}
