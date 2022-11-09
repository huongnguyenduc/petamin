part of 'chat_list_cubit.dart';

// ChatListStatus
enum ChatListStatus { initial, loading, success, failure }

class ChatListState {
  ChatListState({
    this.status = ChatListStatus.initial,
    this.conversations = const [],
  });

  final ChatListStatus status;
  final List<Conversation> conversations;

  ChatListState copyWith({
    ChatListStatus? status,
    List<Conversation>? conversations,
  }) {
    return ChatListState(
      status: status ?? this.status,
      conversations: conversations ?? this.conversations,
    );
  }
}
