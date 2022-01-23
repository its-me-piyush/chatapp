import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../constants.dart';

class TypeMessage extends StatefulWidget {
  const TypeMessage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  State<TypeMessage> createState() => _TypeMessageState();
}

class _TypeMessageState extends State<TypeMessage> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage(String _message, User user) async {
    FocusScope.of(context).unfocus();
    var time = DateTime.now().millisecondsSinceEpoch;
    await FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(formatId(cUser().uid, widget.id))
        .collection(formatId(cUser().uid, widget.id))
        .doc(time.toString())
        .set({
      'from': user.uid,
      'to': widget.id,
      'message': _message,
      'timeStamp': time,
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: '',
                    hintText: 'Type Something!',
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  _controller.text.trim().isEmpty
                      ? null
                      : _sendMessage(_controller.text.trim(), cUser());
                  // var message = _controller.text.trim().isEmpty?null ;
                },
                icon: const Icon(
                  Icons.send_rounded,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
