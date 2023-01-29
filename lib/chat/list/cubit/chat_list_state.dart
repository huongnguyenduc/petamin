part of 'chat_list_cubit.dart';

// ChatListStatus
enum ChatListStatus { initial, loading, success, failure }

class ChatListState extends Equatable {
  ChatListState({
    this.status = ChatListStatus.initial,
    this.conversations = const [],
    this.onlineUsers = const [],
  });

  final ChatListStatus status;
  final List<Conversation> conversations;
  final List<String> onlineUsers;

  ChatListState copyWith({
    ChatListStatus? status,
    List<Conversation>? conversations,
    List<String>? onlineUsers,
  }) {
    return ChatListState(
      status: status ?? this.status,
      conversations: conversations ?? this.conversations,
      onlineUsers: onlineUsers ?? this.onlineUsers,
    );
  }

  @override
  List<Object> get props => [status, conversations, onlineUsers];
}
