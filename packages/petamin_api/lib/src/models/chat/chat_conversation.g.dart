// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatConversation _$ChatConversationFromJson(Map<String, dynamic> json) =>
    ChatConversation(
      id: json['id'] as String,
      title: json['title'] as String?,
      description: json['description'] as String?,
      background: json['background'] as String?,
      emoji: json['emoji'] as String?,
      lastMessageId: json['lastMessageId'] as String,
      users: (json['users'] as List<dynamic>)
          .map((e) => ChatUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastMessage: json['lastMessage'] == null
          ? null
          : ChatLastMessage.fromJson(
              json['lastMessage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatConversationToJson(ChatConversation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'background': instance.background,
      'emoji': instance.emoji,
      'lastMessageId': instance.lastMessageId,
      'users': instance.users,
      'lastMessage': instance.lastMessage,
    };
