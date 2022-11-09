import 'package:json_annotation/json_annotation.dart';

import 'chat.dart';

part 'chat_conversation.g.dart';

// Parse List of ChatConversation from JSON to Dart
List<ChatConversation> chatConversationFromJson(List<dynamic> conversations) =>
    List<ChatConversation>.from(conversations.map((x) => ChatConversation.fromJson(x)));

@JsonSerializable(includeIfNull: false)
class ChatConversation {
  ChatConversation({
    this.id = "",
    this.lastMessageId = "",
    this.users = const [],
    this.lastMessage,
  });

  String? id;
  String? lastMessageId;
  List<ChatUser>? users;
  ChatLastMessage? lastMessage;

  factory ChatConversation.fromJson(Map<String, dynamic> json) => _$ChatConversationFromJson(json);

  Map<String, dynamic> toJson() => _$ChatConversationToJson(this);
}
