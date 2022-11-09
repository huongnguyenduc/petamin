// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatProfile _$ChatProfileFromJson(Map<String, dynamic> json) => ChatProfile(
      id: json['id'] as String? ?? "",
      name: json['name'] as String? ?? "",
      avatar: json['avatar'] as String? ?? "",
    );

Map<String, dynamic> _$ChatProfileToJson(ChatProfile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('avatar', instance.avatar);
  return val;
}
