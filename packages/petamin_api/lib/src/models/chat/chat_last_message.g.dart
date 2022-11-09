// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_last_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatLastMessage _$ChatLastMessageFromJson(Map<String, dynamic> json) =>
    ChatLastMessage(
      id: json['id'] as String,
      status: json['status'] as bool,
      message: json['message'] as String,
      userId: json['userId'] as String,
      conversationId: json['conversationId'] as String,
    );

Map<String, dynamic> _$ChatLastMessageToJson(ChatLastMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'message': instance.message,
      'userId': instance.userId,
      'conversationId': instance.conversationId,
    };
