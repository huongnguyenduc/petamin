import 'dart:async';

import 'package:Petamin/app/app.dart';
import 'package:Petamin/app/cubit/socket_io/socket_io_cubit.dart';
import 'package:Petamin/home/home.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'landing_state.dart';

class LandingCubit extends Cubit<LandingState> {
  LandingCubit({required this.socketIoCubit, required this.appSessionBloc}) : super(LandingState());

  final SocketIoCubit socketIoCubit;
  final AppSessionBloc appSessionBloc;
  late StreamSubscription<List<String>> onlineSubscription;

  void initSocket() {
    // socketIoCubit.initSocket();
    // Wait for 2 seconds to get the online users
    // Future.delayed(Duration(seconds: 1, milliseconds: 500), () {
    if (socketIoCubit.state is SocketIoConnected) {
      print('Socket update online from landing page');
      updateOnline((socketIoCubit.state as SocketIoConnected).onlineUsers);
    }
    // });
    listenToSocket();
  }

  void listenToSocket() {
    // Receive online
    print('listen Socket from landing page');
    onlineSubscription = socketIoCubit.onlineStream.stream.listen((onlineUsers) {
      print('Update Socket Online users from landing page: $onlineUsers');
      updateOnline(onlineUsers);
    });
    print('listeneddd socket from landing page');
  }

  void updateOnline(List<String> onlineUsers) {
    if (isClosed) return;
    final me = onlineUsers.firstWhere((element) => element.compareTo(appSessionBloc.state.session.userId ?? '') == 0,
        orElse: () => '');
    if (me.isNotEmpty && state.isOnline == false) {
      emit(state.copyWith(isOnline: true));
    } else if (state.isOnline) {
      emit(state.copyWith(isOnline: false));
    }
  }

  @override
  Future<void> close() async {
    await onlineSubscription?.cancel();
    print('Landing cubit closed');
    return super.close();
  }
}
