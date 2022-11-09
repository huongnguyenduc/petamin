import 'package:json_annotation/json_annotation.dart';

import 'chat.dart';

part 'chat_conversation.g.dart';

@JsonSerializable()
class ChatConversation {
  ChatConversation({
    required this.id,
    this.title,
    this.description,
    this.background,
    this.emoji,
    required this.lastMessageId,
    required this.users,
    this.lastMessage,
  });

  String id;
  String? title;
  String? description;
  String? background;
  String? emoji;
  String lastMessageId;
  List<ChatUser> users;
  ChatLastMessage? lastMessage;

  factory ChatConversation.fromJson(Map<String, dynamic> json) => _$ChatConversationFromJson(json);

  Map<String, dynamic> toJson() => _$ChatConversationToJson(this);
}
