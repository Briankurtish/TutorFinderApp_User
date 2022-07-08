import 'package:finder_app/auth/auth_page.dart';
import 'package:finder_app/screens/HomeScreen.dart';
import 'package:finder_app/screens/homepage.dart';
import 'package:finder_app/screens/login_page.dart';
import 'package:finder_app/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainScreen(),
    );
  }
}
