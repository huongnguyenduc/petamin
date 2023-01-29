import 'package:json_annotation/json_annotation.dart';

part 'chat_message.g.dart';

// Parse List of ChatMessage from JSON to Dart
List<ChatMessage> chatMessageFromJson(List<dynamic> messages) =>
    List<ChatMessage>.from(messages.map((x) => ChatMessage.fromJson(x)));

@JsonSerializable(includeIfNull: false)
class ChatMessage {
  ChatMessage({
    this.id,
    this.createdAt,
    this.message,
    this.type,
    this.userId,
    this.conversationId,
  });

  String? id;
  DateTime? createdAt;
  String? message;
  String? type;
  String? userId;
  String? conversationId;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}
