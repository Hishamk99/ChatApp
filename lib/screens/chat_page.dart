import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:chat_app/widgets/chat_bubble_for_friend.dart';
import 'package:chat_app/widgets/my_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
  });
  static String id = 'ChatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  ScrollController controller = ScrollController();
  TextEditingController controlller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
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
                      controller: controller,
                      reverse: true,
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
                            controller: controlller,
                            onSubmitted: (data) {
                              messages.add(
                                {
                                  kMessage: data,
                                  kCreatedAt: DateTime.now(),
                                  kId: email,
                                },
                              );
                              controlller.clear();
                              controller.animateTo(
                                0,
                                duration: const Duration(milliseconds: 1),
                                curve: Curves.easeIn,
                              );
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
                                      .inversePrimary,
                                ),
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
                            controlller.clear();
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
