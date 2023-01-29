import 'package:Petamin/app/cubit/socket_io/socket_io_cubit.dart';
import 'package:Petamin/chat/chat.dart';
import 'package:Petamin/shared/constants.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petamin_repository/petamin_repository.dart';
import 'package:timeago/timeago.dart' as timeago;

// _getConversation() {
//   Dio()
//       .get(
//     "http://192.168.3.158:3000/users/conversations",
//     options: Options(
//       headers: {
//         "Authorization":
//             "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imh1eUBjb2RlbGlnaHQuY28iLCJ1c2VySWQiOiIwYmQ5NThlNi05YjU5LTQzMDgtODI4MC0zM2RkY2JhYzRhZjEiLCJpYXQiOjE2Njc3MjA5NTcsImV4cCI6MTY2ODMyNTc1N30.N1aqAOa-rxXVLVgLMDQuKzKksD5kP1jViYZw5C1EJxw",
//       },
//     ),
//   )
//       .then((response) {
//     print(response.data);
//     setState(() {
//       _listChat = response.data;
//     });
//   });
// }

class Chat {
  final String name;
  final String text;
  final String time;
  final String messageCount;

  Chat(this.name, this.text, this.time, this.messageCount);
}

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: ChatListPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatListCubit(context.read<PetaminRepository>(), context.read<SocketIoCubit>()..initSocket())
        ..getConversations(),
      child: const ChatListView(),
    );
  }
}

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        backgroundColor: AppTheme.colors.white,
        elevation: 0,
        toolbarHeight: 30,
      ),
      backgroundColor: AppTheme.colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Chat',
            style: CustomTextTheme.heading1(context),
          ),
          SearchBar(),
          Expanded(
            child: BlocBuilder<ChatListCubit, ChatListState>(
              builder: (context, state) {
                return ListView.builder(
                    itemCount: state.conversations.length,
                    itemBuilder: (context, index) {
                      return ChatCard(
                        chat: state.conversations[index],
                        isOnline: state.onlineUsers.contains(state.conversations[index].partner.userId),
                      );
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Ink(
            decoration:
                BoxDecoration(color: AppTheme.colors.superLightPurple, borderRadius: BorderRadius.circular(5.0)),
            child: InkWell(
              onTap: () => {
                Navigator.of(context, rootNavigator: true)
                    .push(MaterialPageRoute(builder: (context) => ChatSearchPage()))
              },
              borderRadius: BorderRadius.circular(10.0),
              splashColor: AppTheme.colors.lightPurple,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/search.svg',
                      width: 20.0,
                      color: AppTheme.colors.grey,
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      'Search',
                      style: CustomTextTheme.label(context, textColor: AppTheme.colors.grey),
                    ),
                  ],
                ),
              ),
            )));
  }
}

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key,
    required this.chat,
    this.isOnline = false,
  }) : super(key: key);

  final Conversation chat;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => ChatPage(conversationId: chat.id))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage:
                      NetworkImage(chat.partner.avatar!.length > 0 ? chat.partner.avatar! : ANONYMOUS_AVATAR),
                  backgroundColor: Colors.transparent,
                ),

                // if (state.onlineUsers.contains(chat.partner.userId)) {
                if (isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 15.0,
                      height: 15.0,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.0),
                      ),
                    ),
                  )
                // } else {
                //   return Container();
                // }
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat.partner.name ?? '',
                      style: CustomTextTheme.label(
                        context,
                        textColor: AppTheme.colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      chat?.lastMessage?.message != null && chat.lastMessage.message!.length > 0
                          ? (chat?.lastMessage?.type.compareTo('IMAGE') == 0
                              ? 'Has sent image'
                              : chat.lastMessage.isMe
                                  ? 'You: ${chat.lastMessage.message}'
                                  : chat.lastMessage.message)
                          : 'Say hello!',
                      style: CustomTextTheme.body2(context, textColor: AppTheme.colors.solidGrey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              chat?.lastMessage?.message != null && chat.lastMessage.message!.length > 0
                  ? timeago.format(chat.lastMessage.time) ?? ''
                  : '',
              // chat?.lastMessage?.time
              style: CustomTextTheme.caption(context, textColor: AppTheme.colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
