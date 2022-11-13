import 'package:json_annotation/json_annotation.dart';
import 'package:petamin_api/petamin_api.dart';

part 'chat_search_pagination.g.dart';

@JsonSerializable(includeIfNull: false)
class ChatSearchPagination {
  final List<ChatUser> data;
  final Pagination meta;

  ChatSearchPagination({
    required this.data,
    required this.meta,
  });

  factory ChatSearchPagination.fromJson(Map<String, dynamic> json) => _$ChatSearchPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$ChatSearchPaginationToJson(this);
}
