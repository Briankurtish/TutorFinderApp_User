import 'package:finder_app/screens/HomeScreen.dart';
import 'package:finder_app/screens/login_page.dart';
import 'package:finder_app/screens/main_screen.dart';
import 'package:finder_app/screens/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logic/providers/auth_provider.dart';

class AuthRoot extends StatelessWidget {
  const AuthRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Authentication>(builder: (_, auth, __) {
      // ignore: avoid_print
      print('Auth state is');
      // ignore: avoid_print
      print(auth.loginState);
      switch (auth.loginState) {
        case AuthState.loggedIn:
          return MainScreen();
        case AuthState.loggedOut:
          return const LoginPage();
        // case AuthState.incomplete:
        // return Completeprofile();
        case AuthState.signup:
          return SignUpPage();
        case AuthState.login:
          return const LoginPage();
        case AuthState.loading:
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        default:
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
      }
      //return user != null ? HomeScreen() : Register();
    });
  }
}
