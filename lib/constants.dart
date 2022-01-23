import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/size_config.dart';

const caPrimaryColor = Color(0xFF150050);
const caPrimaryLightColor = Color(0xFF610094);
const caSecondaryColor = Color(0xFF3F0071);
const caTextColor = Color(0xFF757575);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

bool forgotSnackBar = false;

late String tempPhoneNumber;
late String veriId;

const String caNewUserMessage =
    'User with this credentials was not found!. Please check you credientials or signup :)';
const String caRegistrationFailedMessage =
    'Uhh! Something went worng. Please Try again';
const String caNoRegisteredUserMessage =
    'User not registered!. Please Sign up :)';
const String caResetLinkSendMessage =
    'Password Reset link successful sent, please check your Email!';

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String caEmailNullError = "Please Enter your email";
const String caInvalidEmailError = "Please Enter Valid Email";
const String caPassNullError = "Please Enter your password";
const String caShortPassError = "Password is too short";
const String caMatchPassError = "Passwords don't match";
const String caNamelNullError = "Please Enter your name";
const String caPhoneNumberNullError = "Please Enter your phone number";
const String caPhoneNumberValidError = 'Please Enter a valid phone number';

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: caTextColor),
  );
}

String readTimestamp(int timestamp) {
  var now = DateTime.now();
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    if (diff.inHours > 0) {
      time = diff.inHours.toString() + 'h ago';
    } else if (diff.inMinutes > 0) {
      time = diff.inMinutes.toString() + 'm ago';
    } else if (diff.inSeconds > 0) {
      time = 'now';
    } else if (diff.inMilliseconds > 0) {
      time = 'now';
    } else if (diff.inMicroseconds > 0) {
      time = 'now';
    } else {
      time = 'now';
    }
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    time = diff.inDays.toString() + 'd ago';
  } else if (diff.inDays > 6) {
    time = (diff.inDays / 7).floor().toString() + 'w ago';
  } else if (diff.inDays > 29) {
    time = (diff.inDays / 30).floor().toString() + 'm ago';
  } else if (diff.inDays > 365) {
    time = '${date.month}-${date.day}-${date.year}';
  }
  return time;
}

User cUser() {
  return FirebaseAuth.instance.currentUser!;
}

String formatId(String id1, String id2) {
  String trial = id1.toLowerCase() + id2.toLowerCase();
  var data = trial.split('');
  data.sort((a, b) {
    return a.toLowerCase().compareTo(b.toLowerCase());
  });
  return data.join('');
}

FirebaseAuth auth() {
  return FirebaseAuth.instance;
}

FirebaseFirestore firebaseFirestore() {
  return FirebaseFirestore.instance;
}
