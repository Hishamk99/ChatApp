import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({super.key, required this.message});
  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Text(
          message.message,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
