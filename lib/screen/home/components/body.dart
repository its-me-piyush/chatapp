import 'package:chatapp/components/custom_surfix_icon.dart';
import 'package:chatapp/screen/sign_in/sign_in_screen.dart';
import 'package:chatapp/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import 'chat_screen.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
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
                  leading: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.54),
                    backgroundImage: AssetImage('assets/images/user.png'),
                    radius: getProportionateScreenWidth(25),
                  ),
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
    );
  }
}
