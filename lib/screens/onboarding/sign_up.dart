import 'package:arina/screens/onboarding/login.dart';
import 'package:arina/widgets/arina_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            height: 812,
            child: Stack(
              children: [
                Positioned(
                  top: 21.87,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 105,
                        height: 1,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFBDBDBD),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2)),
                        ),
                      ),
                      SvgPicture.asset("assets/svg/Group.svg"),
                      Container(
                        width: 105,
                        height: 1,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFBDBDBD),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2)),
                        ),
                      )
                    ],
                  ),
                ),
                const Positioned(
                  top: 116,
                  left: 30,
                  child: SizedBox(
                    height: 83,
                    width: 216,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'WELCOME',
                          style: TextStyle(
                            color: Color(0xFF303030),
                            fontSize: 24,
                            fontFamily: 'Merriweather',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // FORM
                Positioned(
                  left: 0,
                  top: 171,
                  child: Container(
                    width: 345,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x338A959E),
                          blurRadius: 30,
                          offset: Offset(0, 7),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        top: 35,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Name',
                            style: TextStyle(
                              color: Color(0xFF909090),
                              fontSize: 14,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextFormField(),
                          const SizedBox(
                            height: 35,
                          ),
                          const Text(
                            'Email',
                            style: TextStyle(
                              color: Color(0xFF909090),
                              fontSize: 14,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextFormField(),
                          const SizedBox(
                            height: 35,
                          ),
                          const Text(
                            'Password',
                            style: TextStyle(
                              color: Color(0xFF909090),
                              fontSize: 14,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 500,
                            height: 40,
                            child: Stack(
                              children: [
                                const SizedBox(
                                  width: 400,
                                  height: 40,
                                  child: TextField(
                                    obscureText: true,
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        Icons.remove_red_eye_outlined),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          const Text(
                            'Confirm Password',
                            style: TextStyle(
                              color: Color(0xFF909090),
                              fontSize: 14,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 500,
                            height: 40,
                            child: Stack(
                              children: [
                                const SizedBox(
                                  width: 400,
                                  height: 40,
                                  child: TextField(
                                    obscureText: true,
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        Icons.remove_red_eye_outlined),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),

                          // BUTTON
                          ArinaButton(
                            text: 'Sign Up',
                            onPressed: () {},
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have account? ',
                                style: TextStyle(
                                  color: Color(0xFF808080),
                                  fontSize: 14,
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginIn()),
                                    );
                                  },
                                  child: const Text(
                                    'SIGN IN',
                                    style: TextStyle(
                                      color: Color(0xFF303030),
                                      fontSize: 14,
                                      fontFamily: 'Nunito Sans',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 37,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
