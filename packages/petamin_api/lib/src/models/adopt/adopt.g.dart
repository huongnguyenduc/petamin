// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adopt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Adopt _$AdoptFromJson(Map<String, dynamic> json) => Adopt(
      id: json['id'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'] as String?,
      status: json['status'] as String?,
      petId: json['petId'] as String?,
      userId: json['userId'] as String?,
      pet: json['pet'] == null
          ? null
          : PetRes.fromJson(json['pet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdoptToJson(Adopt instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'description': instance.description,
      'status': instance.status,
      'petId': instance.petId,
      'userId': instance.userId,
      'pet': instance.pet,
    };
