import 'dart:async';

import 'package:Petamin/app/cubit/socket_io/socket_io_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petamin_repository/petamin_repository.dart';

part 'chat_list_state.dart';

class ChatListCubit extends Cubit<ChatListState> {
  ChatListCubit(this._petaminRepository, this._socketIoCubit) : super(ChatListState());
  PetaminRepository _petaminRepository;
  SocketIoCubit _socketIoCubit;
  late StreamSubscription<List<String>> onlineSubscription;
  late StreamSubscription<Message> messageSubscription;

  // Get conversation
  Future<void> getConversations() async {
    try {
      emit(state.copyWith(status: ChatListStatus.loading));
      print('getConversations');
      final conversations = await _petaminRepository.getChatConversations();
      print('Conversations: $conversations');
      emit(state.copyWith(status: ChatListStatus.success, conversations: conversations));
      if (_socketIoCubit.state is SocketIoConnected) {
        print('Socket update online from chat list page');
        emit(state.copyWith(onlineUsers: (_socketIoCubit.state as SocketIoConnected).onlineUsers));
      }
      listenToSocket();
    } catch (e) {
      print('Error conversation: $e');
      emit(state.copyWith(status: ChatListStatus.failure));
    }
  }

  // Listen to socket
  void listenToSocket() {
    onlineSubscription = _socketIoCubit.onlineStream.stream.listen((onlineUsers) {
      print('Listen socket from chat list cubit');
      print('Online users: $onlineUsers');
      emit(state.copyWith(onlineUsers: onlineUsers));
    });
    messageSubscription = _socketIoCubit.messageStream.stream.listen((message) async {
      final conversations = await _petaminRepository.getChatConversations();
      emit(state.copyWith(status: ChatListStatus.success, conversations: conversations));
    });
  }

  @override
  Future<void> close() async {
    await onlineSubscription?.cancel();
    await messageSubscription?.cancel();
    print('Chat list cubit closed');
    return super.close();
  }
}
