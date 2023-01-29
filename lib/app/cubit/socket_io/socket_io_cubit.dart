import 'dart:async';

import 'package:Petamin/app/app.dart';
import 'package:Petamin/app/cubit/socket_io/modal.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:petamin_repository/petamin_repository.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

part 'socket_io_state.dart';

class SocketIoCubit extends Cubit<SocketIoState> {
  IO.Socket? socket;
  String? accessToken;
  StreamController<Message>? messageController;
  StreamController<List<String>>? onlineController;
  StreamController<TypingMessage>? typingController;
  final AppSessionBloc appSessionBloc;

  SocketIoCubit({required this.appSessionBloc}) : super(SocketIoInitial());

  void checkSocket() {
    if (accessToken?.compareTo(appSessionBloc.state.session.accessToken) != 0) {
      print('Socket token changed abcd1234');
      closeSocket();
      initSocket();
    }
  }

  void listenToAppSession() {
    appSessionBloc.stream.listen((state) {
      if (state.session.isNotEmpty) {
        initSocket();
      } else {
        closeSocket();
      }
    });
  }

  void initSocket() {
    if (socket != null && accessToken?.compareTo(appSessionBloc.state.session.accessToken) == 0) {
      print('Socket already connected');
      return;
    }
    print('Socket connecting...');
    print('Socket token: ${appSessionBloc.state.session.accessToken}');
    print('Socket user id: ${appSessionBloc.state.session.userId}');
    accessToken = appSessionBloc.state.session.accessToken;
    final apiLink = dotenv.env['API_LINK'];
    socket = IO.io(apiLink, <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
      'extraHeaders': {
        'Authorization': 'Bearer ${appSessionBloc.state.session.accessToken}',
      },
    });

    socket?.connect();
    socket?.onConnect((_) {
      checkSocket();
      print('Socket Connection established from root');
      if (isClosed) return;
      emit(SocketIoConnected());
    });

    socket?.onDisconnect((_) {
      print('Socket Connection Disconnection');
      if (isClosed) return;
      emit(SocketIoDisconnected());
    });

    socket?.onConnectError((err) {
      checkSocket();
      print('Socket onConnect error $err');
      if (isClosed) return;
      emit(SocketIoConnectError(err));
    });

    socket?.onError((err) {
      checkSocket();
      print('Socket connect error $err');
      if (isClosed) {
        print('Socket connect error $err');
      }
      emit(SocketIoError(err));
    });

    socket?.on('message', (data) {
      checkSocket();
      print('socket received message from client ${data}');
      if (isClosed) {
        print('Socket io message has been closed');
      }
      Message newMessage = Message(
          message: data['message'],
          type: data['type'],
          conversationId: data['conversationId'],
          isMe: (data['userId'] as String).compareTo(appSessionBloc.state.session.userId) == 0,
          time: DateTime.now().toLocal());
      messageStream.add(newMessage);
    });

    socket?.on('online', (data) {
      checkSocket();
      print('socket received online from client ${data}');
      List<String> onlineUsers = (data as List<dynamic>).map((userId) => userId.toString()).toList();
      if (isClosed) {
        print('Socket io online has been closed');
      }
      onlineStream.add(onlineUsers);
      emit(SocketIoConnected(onlineUsers: onlineUsers));
    });

    socket?.on('typing', (data) {
      checkSocket();
      if (isClosed) {
        print('Socket io typing has been closed');
      }
      print('socket received typingggggggg from client ${data}');
      TypingMessage typingMessage = TypingMessage(conversationId: data['conversationId'], isTyping: data['isTyping']);
      typingStream.add(typingMessage);
    });
  }

  StreamController<Message> get messageStream {
    checkSocket();
    print('Get socket message stream');
    if (messageController == null || messageController?.isClosed == true) {
      print('Create new socket message stream');
      messageController = StreamController<Message>.broadcast();
    }
    return messageController!;
  }

  StreamController<List<String>> get onlineStream {
    checkSocket();
    print('Get socket online stream');
    if (onlineController == null || onlineController?.isClosed == true) {
      print('Create new socket online stream');
      onlineController = StreamController<List<String>>.broadcast();
    }
    return onlineController!;
  }

  StreamController<TypingMessage> get typingStream {
    checkSocket();
    print('Get socket typing stream');
    if (typingController == null || typingController?.isClosed == true) {
      print('Create new socket typing stream');
      typingController = StreamController<TypingMessage>.broadcast();
    }
    return typingController!;
  }

  void sendMessage({required String message, required String conversationId, String type = 'TEXT'}) {
    checkSocket();
    if (isClosed) {
      print('Socket io send $type has been closed');
    }
    if (socket != null && socket?.connected == true) {
      print('Socket io send $type $message');
      socket?.emit('message', {
        'message': message,
        'type': type,
        'conversationId': conversationId,
      });
    } else {
      print('Socket io send $type has not been connected');
    }
  }

  void sendTyping({required String conversationId, required bool isTyping}) {
    checkSocket();
    if (isClosed) {
      print('Socket io send typing has been closed');
    }
    if (socket != null && socket?.connected == true) {
      socket?.emit('typing', {
        'conversationId': conversationId,
        'isTyping': isTyping,
      });
    } else {
      print('Socket io send typing has not been connected');
    }
  }

  void closeSocket() {
    if (isClosed) {
      print('Socket io has been closed');
    }
    print('Socket force closeeeeeeeeeeeeeeeeeeee');
    socket?.disconnect();
    socket?.dispose();
    socket?.destroy();
    socket = null;
    if (messageController != null) {
      messageController!.close();
      messageController = null;
    }
    if (onlineController != null) {
      onlineController!.close();
      onlineController = null;
    }
    if (typingController != null) {
      typingController!.close();
      typingController = null;
    }
  }

  @override
  Future<void> close() {
    print('Socket self closeeeeeeeeeeeeeeeeeeee');
    socket?.disconnect();
    socket?.dispose();
    socket?.destroy();
    socket = null;
    if (messageController != null) {
      messageController!.close();
      messageController = null;
    }
    if (onlineController != null) {
      onlineController!.close();
      onlineController = null;
    }
    if (typingController != null) {
      typingController!.close();
      typingController = null;
    }
    return super.close();
  }
}
