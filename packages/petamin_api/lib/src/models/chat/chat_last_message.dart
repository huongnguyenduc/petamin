import 'package:json_annotation/json_annotation.dart';

part 'chat_last_message.g.dart';

@JsonSerializable(includeIfNull: false)
class ChatLastMessage {
  ChatLastMessage({
    this.id = "",
    this.message = "",
    this.userId = "",
    this.createdAt,
    this.type = "",
  });

  String? id;
  String? message;
  String? userId;
  DateTime? createdAt;
  String? type;

  factory ChatLastMessage.fromJson(Map<String, dynamic> json) => _$ChatLastMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatLastMessageToJson(this);
}
