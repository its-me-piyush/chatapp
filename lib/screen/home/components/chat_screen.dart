import 'package:chatapp/constants.dart';
import 'package:flutter/material.dart';

import 'type_message.dart';
import 'display_messages_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    Key? key,
    required this.toId,
    required this.name,
  }) : super(key: key);
  final String toId;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: caPrimaryColor,
        title: Text(name),
      ),
      body: Column(
        children: [
          Expanded(
            child: DisplayMessage(toId: toId),
          ),
          const Divider(
            height: 10,
            color: Colors.grey,
          ),
          TypeMessage(id: toId),
        ],
      ),
    );
  }
}
