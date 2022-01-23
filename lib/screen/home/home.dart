import 'package:chatapp/constants.dart';
import 'package:chatapp/screen/home/components/chat_screen.dart';
import 'package:chatapp/screen/sign_in/sign_in_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: caPrimaryColor,
        title: const Text('Chats'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // print('${cUser().displayName} ${cUser().uid}');
          var data = snapshot.data!.docs
              .where((element) => element['uid'] != cUser().uid)
              .toList();

          if (data.isEmpty) {
            return Center(
              child: ElevatedButton(
                  onPressed: () {
                    auth().signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        SignInScreen.routeName, (route) => false);
                  },
                  child: Text(cUser().displayName!)),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatScreen(
                      toId: data[index]['uid'], name: data[index]['name']),
                ));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(data[index]['name']),
                  ),
                  const Divider(
                    height: 10,
                    color: Colors.black,
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
