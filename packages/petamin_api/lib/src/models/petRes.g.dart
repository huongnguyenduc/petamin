// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'petRes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetRes _$PetFromJson(Map<String, dynamic> json) => PetRes(
      id: json['id'] as String?,
      name: json['name'] as String?,
      month: json['month'] as int?,
      year: json['year'] as int?,
      gender: json['gender'] as String?,
      breed: json['breed'] as String?,
      isNeuter: json['isNeuter'] as bool?,
      avatarUrl: json['avatarUrl'] as String?,
      weight: json['weight'] as double?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$PetToJson(PetRes instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'month': instance.month,
      'year': instance.year,
      'gender': instance.gender,
      'breed': instance.breed,
      'isNeuter': instance.isNeuter,
      'avatarUrl': instance.avatarUrl,
      'weight': instance.weight,
      'description': instance.description,
    };
