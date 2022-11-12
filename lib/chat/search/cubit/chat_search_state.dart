part of 'chat_search_cubit.dart';

// ChatSearchStatus
enum ChatSearchStatus {
  initial,
  searching,
  success,
  failure,
}

class ChatSearchState extends Equatable {
  ChatSearchState({
    this.searchQuery = '',
    this.searchResults = const [],
    this.paginationData = const PaginationData.initial(),
    this.status = ChatSearchStatus.initial,
  });

  final String searchQuery;
  final List<Profile> searchResults;
  final PaginationData paginationData;
  final ChatSearchStatus status;

  @override
  List<Object> get props => [searchQuery, searchResults, paginationData, status];

  ChatSearchState copyWith({
    String? searchQuery,
    List<Profile>? searchResults,
    PaginationData? paginationData,
    ChatSearchStatus? status,
  }) =>
      ChatSearchState(
        searchQuery: searchQuery ?? this.searchQuery,
        searchResults: searchResults ?? this.searchResults,
        paginationData: paginationData ?? this.paginationData,
        status: status ?? this.status,
      );
}
