part of 'explore_cubit.dart';

// ChatSearchStatus
enum ExploreStatus {
  newQuery,
  initial,
  searching,
  success,
  failure,
}

class ExploreState extends Equatable {
  ExploreState({
    this.searchQuery = '',
    this.searchResults = const [],
    this.paginationData = const PaginationData.initial(),
    this.status = ExploreStatus.initial,
  });

  final String searchQuery;
  final List<Profile> searchResults;
  final PaginationData paginationData;
  final ExploreStatus status;

  @override
  List<Object> get props =>
      [searchQuery, searchResults, paginationData, status];

  ExploreState copyWith({
    String? searchQuery,
    List<Profile>? searchResults,
    PaginationData? paginationData,
    ExploreStatus? status,
  }) =>
      ExploreState(
        searchQuery: searchQuery ?? this.searchQuery,
        searchResults: searchResults ?? this.searchResults,
        paginationData: paginationData ?? this.paginationData,
        status: status ?? this.status,
      );
}
