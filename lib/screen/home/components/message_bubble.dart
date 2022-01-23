import 'package:chatapp/constants.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key,
      required this.isMe,
      required this.message,
      required this.timeStamp})
      : super(key: key);
  final bool isMe;
  final String message;
  final int timeStamp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
                color: isMe
                    ? Colors.deepPurple[400]
                    : caPrimaryLightColor.withOpacity(0.64),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: !isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                  bottomRight: !isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                )),
            width: 140,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
            margin: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 8,
            ),
            child: Column(
              children: [
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    readTimestamp(timeStamp),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )),
      ],
    );
  }
}
