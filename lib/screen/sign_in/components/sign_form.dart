import 'package:flutter/material.dart';

import '/helper/keyboard.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '/components/form_error.dart';
import '/components/default_button.dart';
import '/components/custom_surfix_icon.dart';
import '/screen/login_success/login_success_screen.dart';
import '../../forgot_password/forgot_password_screen.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
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

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await auth()
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        KeyboardUtil.hideKeyboard(context);
        Navigator.pushNamedAndRemoveUntil(
            context, LoginSuccessScreen.routeName, (route) => false);
      }).catchError((e) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            caNewUserMessage,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
      });
    }
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
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: caPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                signIn(email!, password!);
              }
            },
          ),
        ],
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
        return;
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
