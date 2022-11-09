// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatConversation _$ChatConversationFromJson(Map<String, dynamic> json) =>
    ChatConversation(
      id: json['id'] as String? ?? "",
      lastMessageId: json['lastMessageId'] as String? ?? "",
      users: (json['users'] as List<dynamic>?)
              ?.map((e) => ChatUser.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      lastMessage: json['lastMessage'] == null
          ? null
          : ChatLastMessage.fromJson(
              json['lastMessage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatConversationToJson(ChatConversation instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('lastMessageId', instance.lastMessageId);
  writeNotNull('users', instance.users);
  writeNotNull('lastMessage', instance.lastMessage);
  return val;
}
