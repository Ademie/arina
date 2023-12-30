import 'package:flutter/material.dart';

class WelcomeSplash extends StatelessWidget {
  const WelcomeSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          Positioned(
            left: 104,
            top: 342,
            child: Container(
              width: 167,
              height: 84,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/small_logo.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset(
              "assets/images/Vector2.png",
            ),
          ),
          Positioned(
            left: 120,
            bottom: 0,
            child: Image.asset(
              "assets/images/Vector1.png",
            ),
          ),
        ],
      ),
    ));
  }
}
