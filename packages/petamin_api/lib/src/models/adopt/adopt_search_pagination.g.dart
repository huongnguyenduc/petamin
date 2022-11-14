// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adopt_search_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdoptSearchPagination _$AdoptSearchPaginationFromJson(
        Map<String, dynamic> json) =>
    AdoptSearchPagination(
      data: (json['data'] as List<dynamic>)
          .map((e) => Adopt.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Pagination.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdoptSearchPaginationToJson(
        AdoptSearchPagination instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };
