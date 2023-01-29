import 'package:Petamin/app/cubit/socket_io/socket_io_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:petamin_repository/petamin_repository.dart';

part 'chat_search_state.dart';

class ChatSearchCubit extends Cubit<ChatSearchState> {
  ChatSearchCubit(this._petaminRepository, this._socketIoCubit) : super(ChatSearchState());

  final PetaminRepository _petaminRepository;
  final SocketIoCubit _socketIoCubit;

  void search(String query) async {
    debugPrint('call_cubit: $query');
    debugPrint('call_cubit: ${query.isEmpty}');
    if (query.length == 0) {
      emit(state.copyWith(
          status: ChatSearchStatus.initial,
          searchResults: [],
          searchQuery: query,
          paginationData: PaginationData.initial()));
      debugPrint('empty: $query');
      return;
    }
    bool isFirstSearch = state.status == ChatSearchStatus.initial;
    bool isNewQuery = state.status == ChatSearchStatus.newQuery;
    if (!isFirstSearch && !isNewQuery && state.paginationData.currentPage == state.paginationData.totalPages) {
      debugPrint('${state.paginationData.currentPage}');
      debugPrint('${state.paginationData.totalPages}');
      return;
    }
    debugPrint('first: $query');
    emit(state.copyWith(status: ChatSearchStatus.searching));
    debugPrint('searching: $query');
    try {
      if (query != state.searchQuery) {
        final searchResults = await _petaminRepository.getUserPagination(query: query, limit: 10, page: 1);
        emit(state.copyWith(
          searchQuery: query,
          searchResults: searchResults.users,
          paginationData: searchResults.pagination,
          status: ChatSearchStatus.newQuery,
        ));
      } else {
        debugPrint('current query: $query');
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

  Future<String> createConversations(String userId) async {
    debugPrint('call_cubit: $userId');
    final result = await _petaminRepository.postUserDetailConversation(userId: userId);
    _socketIoCubit.joinRoom(conversationId: result.conversationId, friendId: userId);
    return result.conversationId;
  }
}
