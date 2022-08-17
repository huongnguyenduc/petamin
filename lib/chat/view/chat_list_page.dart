import 'package:flutter/material.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: ChatListPage());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Chat List Page"),
    );
  }
}
