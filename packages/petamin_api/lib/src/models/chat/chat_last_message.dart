import 'package:json_annotation/json_annotation.dart';

part 'chat_last_message.g.dart';

@JsonSerializable(includeIfNull: false)
class ChatLastMessage {
  ChatLastMessage({
    this.id = "",
    this.status = false,
    this.message = "",
    this.userId = "",
  });

  String? id;
  bool? status;
  String? message;
  String? userId;

  factory ChatLastMessage.fromJson(Map<String, dynamic> json) => _$ChatLastMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatLastMessageToJson(this);
}
