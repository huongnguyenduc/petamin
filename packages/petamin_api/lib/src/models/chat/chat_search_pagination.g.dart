// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_search_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatSearchPagination _$ChatSearchPaginationFromJson(
        Map<String, dynamic> json) =>
    ChatSearchPagination(
      data: (json['data'] as List<dynamic>)
          .map((e) => ChatUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Pagination.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatSearchPaginationToJson(
        ChatSearchPagination instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };
