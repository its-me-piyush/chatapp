import 'package:chatapp/constants.dart';
import 'package:chatapp/screen/home/components/settings.dart';
import 'package:chatapp/size_config.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: caPrimaryColor,
        title: const Text(
          'Chats',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Settings.routeName);
            },
            icon: Icon(
              Icons.settings,
              color: Colors.white,
              size: getProportionateScreenWidth(30),
            ),
          ),
        ],
      ),
      body: const Body(),
    );
  }
}
