import 'package:flutter/material.dart';

import '/size_config.dart';
import '../../constants.dart';
import '../message/message.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  _ProfilepageState createState() => _ProfilepageState();
}

void saveData(String? name, BuildContext context) async {
  await cUser().updateDisplayName(name);
  // await FirebaseFirestore.instance.collection('users').doc(cUser().uid).set({
  //   'name': name,
  //   'uid': cUser().uid,
  // });
  

  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MessageScreen(),
      ),
      (route) => false);
}

class _ProfilepageState extends State<Profilepage> {
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            const SizedBox(height: 24),
            TextField(
              controller: firstController,
              decoration: const InputDecoration(
                label: Text('First Name'),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            TextField(
              controller: lastController,
              decoration: const InputDecoration(
                label: Text('Last Name'),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            ElevatedButton(
              onPressed: () {
                var name = firstController.text.trim() +
                    " " +
                    lastController.text.trim();
                saveData(name, context);
              },
              child: const Text(
                'Continue',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
