import 'package:chatapp/screen/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var name = FirebaseAuth.instance.currentUser?.displayName;
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text(name!),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil(
                SignInScreen.routeName, (route) => false);
          },
        ),
      ),
    );
  }
}
