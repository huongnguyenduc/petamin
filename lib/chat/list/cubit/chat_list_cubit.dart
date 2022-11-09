import 'package:bloc/bloc.dart';
import 'package:petamin_repository/petamin_repository.dart';

part 'chat_list_state.dart';

class ChatListCubit extends Cubit<ChatListState> {
  ChatListCubit(this._petaminRepository) : super(ChatListState());
  PetaminRepository _petaminRepository;

  // Get conversation
  Future<void> getConversations() async {
    try {
      emit(state.copyWith(status: ChatListStatus.loading));
      print("getConversations");
      final conversations = await _petaminRepository.getChatConversations();
      print("Conversations: $conversations");
      emit(state.copyWith(status: ChatListStatus.success, conversations: conversations));
    } catch (e) {
      print("Error conversation: $e");
      emit(state.copyWith(status: ChatListStatus.failure));
    }
  }
}
