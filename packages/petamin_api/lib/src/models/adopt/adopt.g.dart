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
    );

Map<String, dynamic> _$AdoptToJson(Adopt instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'description': instance.description,
      'status': instance.status,
    };
