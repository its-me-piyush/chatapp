import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../constants.dart';
import 'message_bubble.dart';

class DisplayMessage extends StatelessWidget {
  const DisplayMessage({
    Key? key,
    required this.toId,
  }) : super(key: key);

  final String toId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chatRoom')
          .doc(formatId(cUser().uid, toId))
          .collection(formatId(cUser().uid, toId))
          .orderBy('timeStamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var data = snapshot.data!.docs;

        return data.isEmpty
            ? const Center(
                child: Text('No Chats!!'),
              )
            : ListView.builder(
                reverse: true,
                itemCount: data.length,
                itemBuilder: (context, index) => MessageBubble(
                  isMe: data[index]['from'] == cUser().uid ? true : false,
                  message: data[index]['message'],
                  timeStamp: data[index]['timeStamp'],
                ),
              );
      },
    );
  }
}
