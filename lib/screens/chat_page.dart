import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:chat_app/widgets/my_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  static String id = 'ChatPage';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Chat',
          ),
          actions: [
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
        ),
        drawer: const MyDrawer(),
        body: const Column(
          children: [
            ChatBubble(),
          ],
        ),
      ),
    );
  }
}
