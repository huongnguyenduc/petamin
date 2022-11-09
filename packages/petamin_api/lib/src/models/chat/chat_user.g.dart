// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatUser _$ChatUserFromJson(Map<String, dynamic> json) => ChatUser(
      id: json['id'] as String? ?? "",
      email: json['email'] as String? ?? "",
      profile: json['profile'] == null
          ? null
          : ChatProfile.fromJson(json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatUserToJson(ChatUser instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('email', instance.email);
  writeNotNull('profile', instance.profile);
  return val;
}
