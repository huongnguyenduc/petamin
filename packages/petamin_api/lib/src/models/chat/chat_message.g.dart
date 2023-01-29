// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt'] as String),
      message: json['message'] as String?,
      type: json['type'] as String?,
      userId: json['userId'] as String?,
      conversationId: json['conversationId'] as String?,
    );

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('message', instance.message);
  writeNotNull('type', instance.type);
  writeNotNull('userId', instance.userId);
  writeNotNull('conversationId', instance.conversationId);
  return val;
}
