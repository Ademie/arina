import 'package:arina/screens/onboarding/sign_up.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const SignUp()));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          left: 104,
          top: 342,
          child: Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/png/bath.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: Image.asset(
            "assets/png/bath.png",
            height: 50,
            width: 50,
          ),
        ),
        Positioned(
          left: 120,
          bottom: 0,
          child: Image.asset(
            "assets/png/bath.png",
            height: 50,
            width: 50,
          ),
        ),
      ],
    ));
  }
}
