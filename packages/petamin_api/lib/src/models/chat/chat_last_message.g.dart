// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_last_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatLastMessage _$ChatLastMessageFromJson(Map<String, dynamic> json) => ChatLastMessage(
      id: json['id'] as String? ?? "",
      message: json['message'] as String? ?? "",
      userId: json['userId'] as String? ?? "",
      createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt'] as String),
      type: json['type'] as String? ?? "",
    );

Map<String, dynamic> _$ChatLastMessageToJson(ChatLastMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('message', instance.message);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('userId', instance.userId);
  writeNotNull('createdAt', instance.createdAt);
  writeNotNull('type', instance.createdAt);
  return val;
}
