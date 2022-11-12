// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      json['currentPage'] as int,
      json['itemsPerPage'] as int,
      json['totalItems'] as int,
      json['totalPages'] as int,
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'itemsPerPage': instance.itemsPerPage,
      'totalItems': instance.totalItems,
      'totalPages': instance.totalPages,
    };
