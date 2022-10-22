// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      description: json['description'] as String?,
      gender: json['gender'] as String?,
      birthday: json['birthday'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'avatar': instance.avatar,
      'address': instance.address,
      'phone': instance.phone,
      'description': instance.description,
      'gender': instance.gender,
      'birthday': instance.birthday,
    };
