import 'dart:async';

import 'package:chatapp/core/constant/constants.dart';
import 'package:chatapp/core/utils/app_font.dart';
import 'package:chatapp/features/auth/presentation/view/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static String id = "splash_screen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (_) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/scholar.png",
              cacheHeight: 200,
              cacheWidth: 200,
              fit: BoxFit.contain,
            ),

            Text(
              "Chat Group",
              style: TextStyle(
                fontSize: 35,
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontFamily: AppFont.pacifico,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Join the conversation..",
              style: TextStyle(
                fontSize: 20,
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
