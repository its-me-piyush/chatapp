import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '/components/form_error.dart';
import '/components/default_button.dart';
import '/components/custom_surfix_icon.dart';
import '/screen/complete_profile/complete_profile_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? conformPassword;
  bool remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  void signup(String email, String pass) async {
    await auth()
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((value) {
      firebaseFirestore()
          .collection('users')
          .doc(value.user!.uid)
          .set({
            'email': value.user!.email,
            'uid': value.user!.uid,
          })
          .onError((error, stackTrace) => ScaffoldMessenger.of(context)
              .showSnackBar(
                  const SnackBar(content: Text(caRegistrationFailedMessage))))
          .whenComplete(() => Navigator.pushNamedAndRemoveUntil(
              context, CompleteProfileScreen.routeName, (_) => false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                signup(email!, password!);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conformPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: caPassNullError);
        } else if (value.isNotEmpty && password == conformPassword) {
          removeError(error: caMatchPassError);
        }
        conformPassword = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: caPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: caMatchPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
                floatingLabelStyle: TextStyle(color: caPrimaryColor),
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: caPassNullError);
        } else if (value.length >= 8) {
          removeError(error: caShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: caPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: caShortPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
                floatingLabelStyle: TextStyle(color: caPrimaryColor),
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: caEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: caInvalidEmailError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: caEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: caInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        floatingLabelStyle: TextStyle(color: caPrimaryColor),
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
