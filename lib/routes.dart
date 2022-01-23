import 'package:chatapp/screen/home/components/settings.dart';
import 'package:chatapp/screen/home/home.dart';
import 'package:chatapp/screen/otp/otp_screen.dart';
import 'package:flutter/widgets.dart';

import 'screen/sign_in/sign_in_screen.dart';
import 'screen/sign_up/sign_up_screen.dart';
import 'screen/login_success/login_success_screen.dart';
import 'screen/forgot_password/forgot_password_screen.dart';
import 'screen/complete_profile/complete_profile_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  Settings.routeName: (context) => const Settings(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
};
