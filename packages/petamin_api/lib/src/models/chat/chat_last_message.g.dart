// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_last_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatLastMessage _$ChatLastMessageFromJson(Map<String, dynamic> json) =>
    ChatLastMessage(
      id: json['id'] as String? ?? "",
      status: json['status'] as bool? ?? false,
      message: json['message'] as String? ?? "",
      userId: json['userId'] as String? ?? "",
    );

Map<String, dynamic> _$ChatLastMessageToJson(ChatLastMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('status', instance.status);
  writeNotNull('message', instance.message);
  writeNotNull('userId', instance.userId);
  return val;
}
