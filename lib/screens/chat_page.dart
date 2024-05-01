import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:chat_app/widgets/chat_bubble_for_friend.dart';
import 'package:chat_app/widgets/my_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    this.userEmail,
  });
  static String id = 'ChatPage';
  final String? userEmail;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt).snapshots(),
        builder: (context, snapshot) {
          List<MessageModel> messageList = [];
          if (snapshot.hasData) {
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
            }
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Chat',
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.logout,
                  ),
                ),
              ],
            ),
            drawer: const MyDrawer(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: messageList.length,
                      itemBuilder: (context, index) {
                        return messageList[index].id == email
                            ? ChatBubble(
                                message: messageList[index],
                              )
                            : ChatBubbleForFriend(
                                message: messageList[index],
                              );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller,
                            onSubmitted: (data) {
                              messages.add(
                                {
                                  kMessage: data,
                                  kCreatedAt:
                                      DateFormat().format(DateTime.now()),
                                  kId: email,
                                },
                              );
                              controller.clear();
                            },
                            decoration: InputDecoration(
                              hintText: 'Send Message',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            // messages.add(
                            //   {
                            //     kMessage: controller.text,
                            //     kCreatedAt: DateTime.now.toString(),
                            //     kId: widget.id,
                            //   },
                            // );
                            controller.clear();
                          },
                          icon: const Icon(
                            Icons.arrow_upward,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
