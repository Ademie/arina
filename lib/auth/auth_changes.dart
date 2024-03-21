import 'package:arina/auth/auth.dart';
import 'package:arina/screens/entry.dart';
import 'package:arina/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AuthChanges extends StatelessWidget {
  const AuthChanges({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Entry();
          } else {
            return const SplashScreen();
          }
        });
  }
}
