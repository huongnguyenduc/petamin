import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petamin_repository/petamin_repository.dart';

part 'chat_search_state.dart';

class ChatSearchCubit extends Cubit<ChatSearchState> {
  ChatSearchCubit(this._petaminRepository) : super(ChatSearchState());

  final PetaminRepository _petaminRepository;

  void search(String query) async {
    if (query.isEmpty) {
      emit(state.copyWith(
          status: ChatSearchStatus.initial,
          searchResults: [],
          searchQuery: query,
          paginationData: PaginationData.initial()));
    }
    bool isFirstSearch = state.status == ChatSearchStatus.initial;
    if (!isFirstSearch && state.paginationData.currentPage == state.paginationData.totalPages) {
      return;
    }
    emit(state.copyWith(status: ChatSearchStatus.searching));
    try {
      if (query != state.searchQuery) {
        final searchResults = await _petaminRepository.getUserPagination(query: query, limit: 10, page: 1);
        emit(state.copyWith(
          searchQuery: query,
          searchResults: searchResults.users,
          paginationData: searchResults.pagination,
          status: ChatSearchStatus.success,
        ));
      } else {
        final searchResults = await _petaminRepository.getUserPagination(
            query: query, limit: 10, page: isFirstSearch ? 1 : state.paginationData.currentPage + 1);
        emit(state.copyWith(
          searchQuery: query,
          searchResults: [...state.searchResults, ...searchResults.users],
          paginationData: searchResults.pagination,
          status: ChatSearchStatus.success,
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: ChatSearchStatus.failure));
    }
  }
}
