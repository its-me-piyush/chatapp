import 'package:chatapp/screen/home/home.dart';
import 'package:chatapp/screen/otp/otp_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '/components/form_error.dart';
import '/components/default_button.dart';
import '/components/custom_surfix_icon.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({Key? key}) : super(key: key);

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? firstName;
  String? lastName;
  String? phoneNumber;

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

  void saveUserDetails(String firstName, String lastName, String pn) async {
    await firebaseFirestore().collection('users').doc(cUser().uid).update({
      'name': firstName.trim() + ' ' + lastName.trim(),
      'phoneNumber': '+91' + pn,
    });
    await auth()
        .currentUser!
        .updateDisplayName(firstName.trim() + ' ' + lastName.trim());
    await auth().verifyPhoneNumber(
      phoneNumber: '+91' + pn,
      verificationCompleted: (phoneAuthCredential) async {
        
      },
      verificationFailed: (error) {},
      codeSent: (verificationId, resendingToken) {
        veriId = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
    Navigator.pushNamedAndRemoveUntil(
        context, OtpScreen.routeName, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                saveUserDetails(firstName!, lastName!, phoneNumber!);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: caPhoneNumberNullError);
        } else if (value.length == 10) {
          removeError(error: caPhoneNumberValidError);
        }
        phoneNumber = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: caPhoneNumberNullError);
          return "";
        } else if (value.length != 10) {
          addError(error: caPhoneNumberValidError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      decoration: const InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: caNamelNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: caNamelNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
