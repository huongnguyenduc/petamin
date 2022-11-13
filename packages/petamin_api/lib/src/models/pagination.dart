import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable()
class Pagination {
  final int currentPage;
  final int itemsPerPage;
  final int totalItems;
  final int totalPages;

  Pagination(this.currentPage, this.itemsPerPage, this.totalItems, this.totalPages);

  factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
