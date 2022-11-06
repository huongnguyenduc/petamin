// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      accessToken: json['accessToken'] as String,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'userId': instance.userId,
    };
