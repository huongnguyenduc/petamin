import 'package:Petamin/app/bloc/app_bloc.dart';
import 'package:Petamin/call/view/call_screen.dart';
import 'package:Petamin/chat/cubit/chat_detail_cubit.dart';
import 'package:Petamin/chat/view/chat_input_field.dart';
import 'package:Petamin/data/models/call_model.dart';
import 'package:Petamin/home/cubit/home_cubit.dart';
import 'package:Petamin/shared/constants.dart';
import 'package:Petamin/shared/shared_widgets.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'chat_model.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatDetailCubit(),
      child: ChatDetailPage(),
    );
  }
}

class ChatDetailPage extends StatelessWidget {
  const ChatDetailPage({
    Key? key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppSessionBloc bloc) => bloc.state.session);
    return BlocListener<ChatDetailCubit, ChatDetailState>(
        listener: (context, state) {
          //FireCall States
          if (state is ErrorFireVideoCallState) {
            showToast(msg: 'ErrorFireVideoCallState: ${state.message}');
          }
          if (state is ErrorPostCallToFirestoreState) {
            showToast(msg: 'ErrorPostCallToFirestoreState: ${state.message}');
          }
          if (state is ErrorUpdateUserBusyStatus) {
            showToast(msg: 'ErrorUpdateUserBusyStatus ${state.message}');
          }
          if (state is SuccessFireVideoCallState) {
            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                builder: (context) => CallScreen(
                      isReceiver: false,
                      callModel: state.callModel,
                    )));
          }
        },
        child: Scaffold(
          backgroundColor: AppTheme.colors.green,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(72),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppBar(
                centerTitle: true,
                elevation: 0,
                actions: [
                  IconButton(
                      onPressed: () {
                        // call video
                        ChatDetailCubit.get(context).fireVideoCall(
                      callModel: CallModel(                          
                          id: 'call_${UniqueKey().hashCode.toString()}',
                          callerId: user.userId,
                          callerAvatar: 'ưe',
                          callerName: 'Huy',
                          receiverId: 'da283s4wjweYjuqf3PmlkFvBYss1',
                          receiverAvatar: 'ưe',
                          receiverName: 'bui',
                          status: CallStatus.ringing.name,
                          createAt: DateTime.now().millisecondsSinceEpoch,
                        current: true
                      ));
                      },
                      icon: Icon(Icons.call))
                ],
                title: Text(
                  "Peter Thornton",
                  style: CustomTextTheme.heading4(context,
                      textColor: AppTheme.colors.white),
                ),
              ),
            ),
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
                          itemBuilder: (context, index) {
                            switch (state.messages[index].messageType) {
                              case ChatMessageType.text:
                                return TextMessage(
                                    chatMessage: state.messages[index]);
                              case ChatMessageType.image:
                                return ImageMessage(
                                    chatMessage: state.messages[index]);
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

  final ChatMessage chatMessage;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: chatMessage.isSender
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        if (!chatMessage.isSender) ...[
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

  final ChatMessage chatMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: chatMessage.isSender
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!chatMessage.isSender) ...[
            CircleAvatar(
              radius: 14.0,
              backgroundImage: AssetImage('assets/images/dog.png'),
            ),
            SizedBox(width: 12.0),
          ],
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
                color: chatMessage.isSender
                    ? AppTheme.colors.pink
                    : AppTheme.colors.lightPurple,
                borderRadius: BorderRadius.circular(20.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chatMessage.data,
                  style: CustomTextTheme.body2(context,
                      textColor: chatMessage.isSender
                          ? AppTheme.colors.white
                          : AppTheme.colors.green),
                ),
                SizedBox(
                  width: 16.0,
                ),
                Text(
                  '19:15',
                  style: CustomTextTheme.caption(context,
                      textColor: chatMessage.isSender
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
