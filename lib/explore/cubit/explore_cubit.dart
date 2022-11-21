import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:petamin_repository/petamin_repository.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit(this._petaminRepository) : super(ExploreState());
  final PetaminRepository _petaminRepository;
  void search(String query) async {
    //ignore suggestion lazy load
    if (query.isEmpty &&
        state.searchQuery.isEmpty &&
        state.searchResults.length > 0 &&
        state.status == ExploreStatus.initial) {
      return;
    }

    if (query.length == 0) {
      emit(state.copyWith(
          status: ExploreStatus.initial,
          searchResults: [],
          searchQuery: query,
          paginationData: PaginationData.initial()));
      debugPrint('empty: $query');
      return;
    }
    bool isFirstSearch = state.status == ExploreStatus.initial;
    bool isNewQuery = state.status == ExploreStatus.newQuery;
    if (!isFirstSearch &&
        !isNewQuery &&
        state.paginationData.currentPage == state.paginationData.totalPages) {
      debugPrint('${state.paginationData.currentPage}');
      debugPrint('${state.paginationData.totalPages}');
      return;
    }
    debugPrint('first: $query');
    emit(state.copyWith(status: ExploreStatus.searching));
    debugPrint('searching: $query');
    try {
      if (query != state.searchQuery) {
        final searchResults = await _petaminRepository.getUserPagination(
            query: query, limit: 10, page: 1);
        emit(state.copyWith(
          searchQuery: query,
          searchResults: searchResults.users,
          paginationData: searchResults.pagination,
          status: ExploreStatus.newQuery,
        ));
      } else {
        debugPrint('current query: $query');
        final searchResults = await _petaminRepository.getUserPagination(
            query: query,
            limit: 10,
            page: isFirstSearch ? 1 : state.paginationData.currentPage + 1);
        emit(state.copyWith(
          searchQuery: query,
          searchResults: [...state.searchResults, ...searchResults.users],
          paginationData: searchResults.pagination,
          status: ExploreStatus.success,
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: ExploreStatus.failure));
    }
  }

  initData() async {
    emit(state.copyWith(status: ExploreStatus.searching));
    try {
      final searchResults = await _petaminRepository.getUserPagination(
          query: 'k', limit: 10, page: 1);
      emit(state.copyWith(
        searchQuery: '',
        searchResults: searchResults.users,
        paginationData: searchResults.pagination,
        status: ExploreStatus.initial,
      ));
    } catch (e) {
      emit(state.copyWith(status: ExploreStatus.failure));
    }
  }
}
