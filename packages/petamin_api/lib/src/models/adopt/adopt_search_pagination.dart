import 'package:json_annotation/json_annotation.dart';
import 'package:petamin_api/petamin_api.dart';

part 'adopt_search_pagination.g.dart';

@JsonSerializable(includeIfNull: false)
class AdoptSearchPagination {
  final List<Adopt> data;
  final Pagination meta;
  AdoptSearchPagination({
    required this.data,
    required this.meta,
  });
  factory AdoptSearchPagination.fromJson(Map<String, dynamic> json) =>
      _$AdoptSearchPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$AdoptSearchPaginationToJson(this);
}
