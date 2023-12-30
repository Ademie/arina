import 'package:arina/screens/home/home.dart';
import 'package:arina/screens/onboarding/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginIn extends StatelessWidget {
  const LoginIn({super.key});

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
                          'Hello !',
                          style: TextStyle(
                            color: Color(0xFF909090),
                            fontSize: 30,
                            fontFamily: 'Merriweather',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'WELCOME BACK',
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
                  top: 278,
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
                          Center(
                            child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Forgot Password',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF909090),
                                    fontSize: 18,
                                    fontFamily: 'Nunito Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          // BUTTON
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF232323),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              shadowColor: const Color(0x3F303030),
                              elevation: 10,
                            ),
                            child: const SizedBox(
                                width: 260,
                                height: 50,
                                child: Center(
                                    child: Text(
                                  'Log in',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Nunito Sans',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ))),
                          ),

                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUp()),
                                );
                              },
                              child: const Text(
                                'SIGN UP',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF303030),
                                  fontSize: 18,
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ),
                          )
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
