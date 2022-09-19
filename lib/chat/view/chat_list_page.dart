import 'package:Petamin/chat/view/chat_page.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Chat {
  final String name;
  final String text;
  final String time;
  final String messageCount;

  Chat(this.name, this.text, this.time, this.messageCount);
}

final _listChat = [
  Chat('Peter Thornton', 'Can I adopt ur cutie pe...', 'Just now', '2'),
  Chat('B.A. Baracus', 'You are the best!', '23m ago', '21'),
  Chat('Peter Thornton', 'Can I adopt ur cutie pe...', 'Just now', '78'),
  Chat('Peter Thornton', 'Can I adopt ur cutie pe...', 'Just now', '25'),
  Chat('Kha', 'Can I adopt ur cutie pe...', 'Just now', '99+'),
  Chat('Huong', 'Can I adopt ur cutie pe...', 'Just now', '12'),
  Chat('Huy', 'Can I adopt ur cutie pe...', 'Just now', '98'),
  Chat('Khang', 'Can I adopt ur cutie pe...', 'Just now', '65'),
  Chat('Peter Thornton', 'Can I adopt ur cutie pe...', 'Just now', '9'),
];

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: ChatListPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {}, icon: SvgPicture.asset('assets/icons/bell.svg'))
        ],
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
            child: ListView.builder(
                itemCount: _listChat.length,
                itemBuilder: (context, index) {
                  return ChatCard(
                      chat: _listChat[index],
                      onTap: () => Navigator.of(context, rootNavigator: true)
                          .push(MaterialPageRoute(
                              builder: (context) => const ChatPage())));
                }),
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
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: AppTheme.colors.superLightPurple),
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
              style: CustomTextTheme.label(context,
                  textColor: AppTheme.colors.grey),
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
    required this.onTap,
  }) : super(key: key);

  final Chat chat;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                    decoration: BoxDecoration(
                        color: AppTheme.colors.pink,
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Center(
                      child: Text(
                        chat.messageCount,
                        style: CustomTextTheme.caption(context,
                            textColor: AppTheme.colors.white,
                            fontWeight: FontWeight.bold),
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
                      _listChat[0].name,
                      style: CustomTextTheme.heading4(context),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      _listChat[0].text,
                      style: CustomTextTheme.label(context,
                          textColor: AppTheme.colors.solidGrey),
                    ),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: 0.5,
              child: Text(
                _listChat[0].time,
                style: CustomTextTheme.caption(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
