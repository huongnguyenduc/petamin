// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'petRes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetRes _$PetResFromJson(Map<String, dynamic> json) => PetRes(
      id: json['id'] as String?,
      name: json['name'] as String?,
      month: json['month'] as int?,
      year: json['year'] as int?,
      gender: json['gender'] as String?,
      breed: json['breed'] as String?,
      isNeuter: json['isNeuter'] as bool?,
      avatarUrl: json['avatarUrl'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
      description: json['description'] as String?,
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => Images.fromJson(e as Map<String, dynamic>))
          .toList(),
      species: json['species'] as String?,
    );

Map<String, dynamic> _$PetResToJson(PetRes instance) => <String, dynamic>{
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
      'species': instance.species,
      'photos': instance.photos,
    };
