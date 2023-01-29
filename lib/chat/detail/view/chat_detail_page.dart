import 'dart:convert';

import 'package:Petamin/app/cubit/socket_io/socket_io_cubit.dart';
import 'package:Petamin/call/view/call_screen.dart';
import 'package:Petamin/chat/chat.dart';
import 'package:Petamin/data/models/call_model.dart';
import 'package:Petamin/profile-info/cubit/profile_info_cubit.dart';
import 'package:Petamin/shared/constants.dart';
import 'package:Petamin/shared/shared_widgets.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:lottie/lottie.dart';
import 'package:petamin_repository/petamin_repository.dart';

// import 'chat_model.dart';

class ChatPage extends StatelessWidget {
  final conversationId;

  const ChatPage({required this.conversationId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatDetailCubit(
          conversationId, context.read<PetaminRepository>(), context.read<SocketIoCubit>()..initSocket()),
      child: ChatDetailPage(),
    );
  }
}

class ChatDetailPage extends StatelessWidget {
  ChatDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((ProfileInfoCubit bloc) => bloc.state);
    debugPrint(user.props.toString());
    debugPrint('Meoww');
    return BlocListener<ChatDetailCubit, ChatDetailState>(
        listener: (context, state) {
          //FireCall States
          if (state.callVideoStatus == CallVideoStatus.ErrorFireVideoCallState) {
            showToast(msg: 'ErrorFireVideoCallState: ${state.errorMessage}');
          }
          if (state.callVideoStatus == CallVideoStatus.ErrorPostCallToFirestoreState) {
            showToast(msg: 'ErrorPostCallToFirestoreState: ${state.errorMessage}');
          }
          if (state.callVideoStatus == CallVideoStatus.SuccessFireVideoCallState) {
            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                builder: (context) => CallScreen(
                      isReceiver: false,
                      callModel: state.callModel!,
                    )));
          }
        },
        child: Scaffold(
          backgroundColor: AppTheme.colors.green,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(72),
            child: BlocBuilder<ChatDetailCubit, ChatDetailState>(
                buildWhen: (previous, current) => previous.partner != current.partner,
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppBar(
                      centerTitle: true,
                      elevation: 0,
                      actions: [
                        IconButton(
                            onPressed: () {
                              // call video
                              // debugPrint(
                              //     'call video: ${state.partner!.avatar!}');
                              // debugPrint('call video: ${user.avatarUrl}');
                              context.read<ChatDetailCubit>().fireVideoCall(
                                  callModel: CallModel(
                                      id: 'call_${UniqueKey().hashCode.toString()}',
                                      callerId: user.userId,
                                      callerAvatar: user.avatarUrl.isNotEmpty ? user.avatarUrl : ANONYMOUS_AVATAR,
                                      callerName: user.name,
                                      receiverId: state.partner!.userId!,
                                      receiverAvatar:
                                          state.partner!.avatar!.isNotEmpty ? state.partner!.avatar! : ANONYMOUS_AVATAR,
                                      receiverName: state.partner!.name!,
                                      status: CallStatus.ringing.name,
                                      createAt: DateTime.now().millisecondsSinceEpoch,
                                      current: true));
                            },
                            icon: Icon(Icons.call))
                      ],
                      title: Text(
                        state.partner?.name ?? '',
                        style: CustomTextTheme.heading4(context, textColor: AppTheme.colors.white),
                      ),
                    ),
                  );
                }),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0))),
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<ChatDetailCubit, ChatDetailState>(
                    buildWhen: (previous, current) => previous.messages != current.messages,
                    builder: (context, state) {
                      return ListView.builder(
                          itemCount: state.messages.length,
                          shrinkWrap: true,
                          reverse: true,
                          controller: context.read<ChatDetailCubit>().scrollController,
                          itemBuilder: (context, index) {
                            switch (state.messages[index].type) {
                              case 'TEXT':
                                return state.messages.length > 0
                                    ? TextMessage(
                                        chatMessage: state.messages[index],
                                        avatar: state?.partner?.avatar,
                                      )
                                    : Container();
                              case 'IMAGE':
                                return state.messages.length > 0
                                    ? ImageMessage(chatMessage: state.messages[index], avatar: state?.partner?.avatar)
                                    : Container();
                              case 'TYPING':
                                return state.messages.length > 0
                                    ? TextMessage(
                                        chatMessage: state.messages[index],
                                        avatar: state?.partner?.avatar,
                                        isTyping: true,
                                      )
                                    : Container();
                              default:
                                return Container();
                            }
                          });
                    },
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    Expanded(child: ChatInputField()),
                    SizedBox(
                      width: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<ChatDetailCubit>().selectMultipleImages();
                      },
                      child: Container(
                        height: 44.0,
                        width: 44.0,
                        decoration: BoxDecoration(
                            color: AppTheme.colors.superLightPurple, borderRadius: BorderRadius.circular(10.0)),
                        child: Icon(
                          Icons.add,
                          color: AppTheme.colors.pink,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 28.0,
                )
              ],
            ),
          ),
        ));
  }
}

class ImageMessage extends StatelessWidget {
  const ImageMessage({
    super.key,
    required this.chatMessage,
    this.avatar = ANONYMOUS_AVATAR,
  });

  final Message chatMessage;
  final String? avatar;

  @override
  Widget build(BuildContext context) {
    String message = chatMessage.message!;
    var jsonImages = jsonDecode(message) as List<dynamic>;
    print(jsonImages);
    print('image: ${jsonImages[0]['url']}');

    return Padding(
      padding: EdgeInsets.only(top: 12.0, right: chatMessage.isMe! ? 0.0 : 60.0, left: chatMessage.isMe! ? 60.0 : 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: chatMessage.isMe! ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!chatMessage.isMe!) ...[
            CircleAvatar(
              radius: 18.0,
              backgroundImage: NetworkImage(avatar!),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(width: 12.0),
          ],
          Flexible(
            child: Directionality(
              textDirection: chatMessage.isMe! ? TextDirection.rtl : TextDirection.ltr,
              child: GridView.builder(
                  shrinkWrap: true,
                  // reverse: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: jsonImages.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(image: NetworkImage(jsonImages[index]['url']), fit: BoxFit.cover)),
                    );
                  }),
            ),
          ),
          // Container(
          //   width: 100.0,
          //   height: 130.0,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(25.0),
          //       image: DecorationImage(image: AssetImage('assets/images/cat-1.jpg'), fit: BoxFit.cover)),
          // ),
          // SizedBox(width: 12.0),
          // Container(
          //   width: 100.0,
          //   height: 130.0,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(25.0),
          //       image: DecorationImage(image: AssetImage('assets/images/cat-2.jpg'), fit: BoxFit.cover)),
          // ),
        ],
      ),
    );
  }
}

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    required this.chatMessage,
    this.avatar = ANONYMOUS_AVATAR,
    this.isTyping = false,
  }) : super(key: key);

  final Message chatMessage;
  final String? avatar;
  final bool isTyping;

  @override
  Widget build(BuildContext context) {
    var timeFormat = intl.DateFormat('HH:mm');

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: chatMessage.isMe! ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!chatMessage.isMe!) ...[
            Stack(
              children: [
                CircleAvatar(
                  radius: 18.0,
                  backgroundImage: NetworkImage(avatar!),
                  backgroundColor: Colors.transparent,
                ),
                BlocBuilder<ChatDetailCubit, ChatDetailState>(
                  buildWhen: (previous, current) => previous.isPartnerOnline != current.isPartnerOnline,
                  builder: (context, state) {
                    return Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 12.0,
                        width: 12.0,
                        decoration: BoxDecoration(
                            color: state.isPartnerOnline ? Colors.green : Colors.grey,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2.0)),
                      ),
                    );
                  },
                )
              ],
            ),
            SizedBox(width: 12.0),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                  color: chatMessage.isMe! ? AppTheme.colors.pink : AppTheme.colors.lightPurple,
                  borderRadius: BorderRadius.circular(20.0)),
              child: isTyping
                  ? Lottie.asset('assets/lottie/typing.json', width: 24, height: 24)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            chatMessage.message!,
                            maxLines: 8,
                            style: CustomTextTheme.body2(context,
                                textColor: chatMessage.isMe! ? AppTheme.colors.white : AppTheme.colors.green),
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          timeFormat.format(chatMessage.time!.toLocal()),
                          style: CustomTextTheme.caption(context,
                              textColor: chatMessage.isMe! ? AppTheme.colors.white : AppTheme.colors.grey),
                        )
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }
}
