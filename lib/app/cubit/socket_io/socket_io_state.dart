part of 'socket_io_cubit.dart';

abstract class SocketIoState extends Equatable {}

class SocketIoInitial extends SocketIoState {
  @override
  List<Object> get props => [];
}

class SocketIoConnected extends SocketIoState {
  SocketIoConnected({this.onlineUsers = const []});

  final List<String> onlineUsers;

  @override
  List<Object> get props => [onlineUsers];
}

class SocketIoDisconnected extends SocketIoState {
  @override
  List<Object> get props => [];
}

class SocketIoError extends SocketIoState {
  SocketIoError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class SocketIoConnectError extends SocketIoState {
  SocketIoConnectError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
