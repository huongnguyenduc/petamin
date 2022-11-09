// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatProfile _$ChatProfileFromJson(Map<String, dynamic> json) => ChatProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      bio: json['bio'] as String?,
      gender: json['gender'] as String?,
      birthday: json['birthday'] as String?,
      totalFollowers: json['totalFollowers'] as int,
      totalFollowings: json['totalFollowings'] as int,
    );

Map<String, dynamic> _$ChatProfileToJson(ChatProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'address': instance.address,
      'phone': instance.phone,
      'bio': instance.bio,
      'gender': instance.gender,
      'birthday': instance.birthday,
      'totalFollowers': instance.totalFollowers,
      'totalFollowings': instance.totalFollowings,
    };
