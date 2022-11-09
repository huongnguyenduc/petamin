import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart';

part 'socket_bloc.freezed.dart';
part 'socket_event.dart';
part 'socket_state.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  late final Socket _socket;
  final String _token;

  SocketBloc({required String token})
      : _token = token,
        super(SocketState.initial()) {
    print("SocketBloc: $_token");
    _socket = io(
      'http://13.212.216.134',
      OptionBuilder().setTimeout(3000).setReconnectionDelay(5000).disableAutoConnect().build(),
    );
    print("SocketBloc: $_token");
    // Add authentication token
    _socket.io.options['extraHeaders'] = {'Authorization': 'Bearer $_token'};
    _socket.onConnecting((data) => add(_SocketConnectingEvent()));
    _socket.onConnect((_) => add(_SocketOnConnect()));
    _socket.onConnectError((data) => add(_SocketConnectErrorEvent()));
    _socket.onConnectTimeout((data) => add(_SocketConnectTimeoutEvent()));
    _socket.onDisconnect((_) => add(_SocketOnDisconnect()));
    _socket.onError((data) => add(_SocketErrorEvent()));
    _socket.on('message_received', (data) => add(_SocketJoinedEvent()));

    // User events
    on<_SocketConnect>((event, emit) {
      _socket.connect();
    });

    on<_SocketDisconnect>((event, emit) {
      _socket.disconnect();
    });
    // Socket events
    on<_SocketConnectingEvent>((event, emit) {
      emit(SocketState.connected("Connecting"));
    });
    on<_SocketOnConnect>((event, emit) {
      emit(SocketState.connected(_socket.id!));
    });
    on<_SocketConnectErrorEvent>((event, emit) {
      emit(SocketState.connected("Connection Error"));
    });
    on<_SocketConnectTimeoutEvent>((event, emit) {
      emit(SocketState.connected("Connection timeout"));
    });
    on<_SocketOnDisconnect>((event, emit) {
      emit(SocketState.disconnected());
    });
    on<_SocketErrorEvent>((event, emit) {
      emit(SocketState.connected("ErrorEvent"));
    });
    on<_SocketJoinedEvent>((event, emit) {
      emit(SocketState.connected("JoinedEvent"));
    });
  }

  @override
  Future<void> close() {
    _socket.dispose();
    return super.close();
  }
}
