import 'package:chatapp/constants.dart';
import 'package:chatapp/screen/sign_in/sign_in_screen.dart';
import 'package:chatapp/size_config.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            onPressed: () {
              auth().signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  SignInScreen.routeName, (route) => false);
            },
            icon: Icon(
              Icons.logout_outlined,
              color: Colors.white,
              size: getProportionateScreenWidth(35),
            ),
          ),
        ],
        backgroundColor: caPrimaryColor,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          CircleAvatar(
            maxRadius: getProportionateScreenWidth(80),
          ),
          Center(
            child: Text(
              cUser().displayName!,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: getProportionateScreenWidth(20),
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          Row(children: [
            Text(
              'Phone Number: ',
              style: TextStyle(
                fontSize: getProportionateScreenWidth(20),
                color: Colors.black,
              ),
            ),
            Text(
              cUser().phoneNumber!,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(20),
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ])
        ],
      ),
    );
  }
}
