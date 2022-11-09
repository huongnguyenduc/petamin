import 'package:Petamin/chat/chat.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petamin_repository/petamin_repository.dart';

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
      create: (context) => ChatListCubit(
        context.read<PetaminRepository>(),
      )..getConversations(),
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
        actions: [IconButton(onPressed: () {}, icon: SvgPicture.asset('assets/icons/bell.svg'))],
        backgroundColor: AppTheme.colors.white,
        elevation: 0,
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
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0), color: AppTheme.colors.superLightPurple),
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
              "Search",
              style: CustomTextTheme.label(context, textColor: AppTheme.colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key,
    required this.chat,
  }) : super(key: key);

  final Conversation chat;

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
                  backgroundImage: AssetImage('assets/images/cat.png'),
                ),
                Positioned(
                  right: -4.0,
                  top: -4.0,
                  child: Container(
                    width: 24.0,
                    height: 24.0,
                    decoration: BoxDecoration(color: AppTheme.colors.pink, borderRadius: BorderRadius.circular(12.0)),
                    child: Center(
                      child: Text(
                        "1",
                        style: CustomTextTheme.caption(context,
                            textColor: AppTheme.colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat.partner.name ?? "",
                      style: CustomTextTheme.heading4(
                        context,
                        textColor: AppTheme.colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      chat.lastMessage.message,
                      style: CustomTextTheme.label(context, textColor: AppTheme.colors.solidGrey),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              chat.lastMessage.isMe ? "You" : chat.partner.name ?? "",
              style: CustomTextTheme.caption(context, textColor: AppTheme.colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
