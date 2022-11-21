import 'package:Petamin/app/bloc/app_bloc.dart';
import 'package:Petamin/call/view/call_screen.dart';
import 'package:Petamin/chat/chat.dart';
import 'package:Petamin/data/models/call_model.dart';
import 'package:Petamin/profile-info/cubit/profile_info_cubit.dart';
import 'package:Petamin/shared/constants.dart';
import 'package:Petamin/shared/shared_widgets.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petamin_repository/petamin_repository.dart';

// import 'chat_model.dart';

class ChatPage extends StatelessWidget {
  final conversationId;

  const ChatPage({required this.conversationId, super.key});

  @override
  Widget build(BuildContext context) {
    // Get session from app bloc
    final session = context.read<AppSessionBloc>().state.session;
    return BlocProvider(
      create: (_) => ChatDetailCubit(conversationId, session.accessToken,
          context.read<PetaminRepository>())
        ..initSocket()
        ..getUserDetailConversation()
        ..getMessages(),
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
    return BlocListener<ChatDetailCubit, ChatDetailState>(
        listener: (context, state) {
          //FireCall States
          if (state.callVideoStatus ==
              CallVideoStatus.ErrorFireVideoCallState) {
            showToast(msg: 'ErrorFireVideoCallState: ${state.errorMessage}');
          }
          if (state.callVideoStatus ==
              CallVideoStatus.ErrorPostCallToFirestoreState) {
            showToast(
                msg: 'ErrorPostCallToFirestoreState: ${state.errorMessage}');
          }
          if (state.callVideoStatus ==
              CallVideoStatus.SuccessFireVideoCallState) {
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
                buildWhen: (previous, current) =>
                    previous.partner != current.partner,
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
                                      id:
                                          'call_${UniqueKey().hashCode.toString()}',
                                      callerId: user.userId,
                                      callerAvatar: user.avatarUrl.isNotEmpty
                                          ? user.avatarUrl
                                          : ANONYMOUS_AVATAR,
                                      callerName: user.name,
                                      receiverId: state.partner!.userId!,
                                      receiverAvatar:
                                          state.partner!.avatar!.isNotEmpty
                                              ? state.partner!.avatar!
                                              : ANONYMOUS_AVATAR,
                                      receiverName: state.partner!.name!,
                                      status: CallStatus.ringing.name,
                                      createAt:
                                          DateTime.now().millisecondsSinceEpoch,
                                      current: true));
                            },
                            icon: Icon(Icons.call))
                      ],
                      title: Text(
                        state.partner?.name ?? '',
                        style: CustomTextTheme.heading4(context,
                            textColor: AppTheme.colors.white),
                      ),
                    ),
                  );
                }),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0))),
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<ChatDetailCubit, ChatDetailState>(
                    buildWhen: (previous, current) =>
                        previous.messages != current.messages,
                    builder: (context, state) {
                      return ListView.builder(
                          itemCount: state.messages.length,
                          shrinkWrap: true,
                          reverse: true,
                          controller:
                              context.read<ChatDetailCubit>().scrollController,
                          itemBuilder: (context, index) {
                            switch (state.messages[index].type) {
                              case "TEXT":
                                return state.messages.length > 0
                                    ? TextMessage(
                                        chatMessage: state.messages[
                                            state.messages.length - 1 - index])
                                    : Container();
                              case "IMAGE":
                                return state.messages.length > 0
                                    ? ImageMessage(
                                        chatMessage: state.messages[
                                            state.messages.length - 1 - index])
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
                    Container(
                      height: 44.0,
                      width: 44.0,
                      decoration: BoxDecoration(
                          color: AppTheme.colors.superLightPurple,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Icon(
                        Icons.add,
                        color: AppTheme.colors.pink,
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
  const ImageMessage({super.key, required this.chatMessage});

  final Message chatMessage;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          chatMessage.isMe! ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!chatMessage.isMe!) ...[
          CircleAvatar(
            radius: 14.0,
            backgroundImage: AssetImage('assets/images/dog.png'),
          ),
          SizedBox(width: 12.0),
        ],
        Container(
          width: 100.0,
          height: 130.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              image: DecorationImage(
                  image: AssetImage('assets/images/cat-1.jpg'),
                  fit: BoxFit.cover)),
        ),
        SizedBox(width: 12.0),
        Container(
          width: 100.0,
          height: 130.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              image: DecorationImage(
                  image: AssetImage('assets/images/cat-2.jpg'),
                  fit: BoxFit.cover)),
        ),
      ],
    );
  }
}

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    required this.chatMessage,
  }) : super(key: key);

  final Message chatMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            chatMessage.isMe! ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!chatMessage.isMe!) ...[
            CircleAvatar(
              radius: 14.0,
              backgroundImage: AssetImage('assets/images/dog.png'),
            ),
            SizedBox(width: 12.0),
          ],
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
                color: chatMessage.isMe!
                    ? AppTheme.colors.pink
                    : AppTheme.colors.lightPurple,
                borderRadius: BorderRadius.circular(20.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chatMessage.message!,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextTheme.body2(context,
                      textColor: chatMessage.isMe!
                          ? AppTheme.colors.white
                          : AppTheme.colors.green),
                ),
                SizedBox(
                  width: 16.0,
                ),
                Text(
                  chatMessage.time!.hour.toString() +
                      ":" +
                      chatMessage.time!.minute.toString(),
                  style: CustomTextTheme.caption(context,
                      textColor: chatMessage.isMe!
                          ? AppTheme.colors.white
                          : AppTheme.colors.grey),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
