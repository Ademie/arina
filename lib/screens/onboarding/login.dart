import 'dart:developer';

import 'package:arina/constants/constants.dart';
import 'package:arina/screens/entry.dart';
import 'package:arina/screens/onboarding/components/forms_header.dart';
import 'package:arina/screens/onboarding/sign_up.dart';
import 'package:arina/widgets/arina_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class LoginIn extends StatefulWidget {
  const LoginIn({super.key});

  @override
  State<LoginIn> createState() => _LoginInState();
}

class _LoginInState extends State<LoginIn> {
  bool _isLoading = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  Future<void> _login({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      setState(() {
        _isLoading = true;
      });
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const Entry();
        }));
        setState(() {
          _isLoading = false;
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        errorMessage = "Email or password is incorrect";
        setState(() {
          _isLoading = true;
        });
        Future.delayed(const Duration(seconds: 2), () {
          showSnack(context, errorMessage);
          setState(() {
            _isLoading = false;
          });
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            height: 812,
            child: Stack(
              children: [
                const FormsHeader(),
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
                      boxShadow: [boxshadow],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        top: 35,
                      ),
                      child: Form(
                        key: _formKey,
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
                            TextFormField(
                              controller: _email,
                            ),
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
                                  SizedBox(
                                    width: 400,
                                    height: 40,
                                    child: TextFormField(
                                      obscureText: _obscurePassword,
                                      autocorrect: false,
                                      enableSuggestions: false,
                                      controller: _password,
                                      validator: (value) {
                                        if (value!.length < 6) {
                                          return 'Password must contain at least 6 characters';
                                        } else if (!value
                                            .contains(RegExp(r'[A-Z]'))) {
                                          return 'Password must contain at least one uppercase letter';
                                        } else if (!value
                                            .contains(RegExp(r'[a-z]'))) {
                                          return 'Password must contain at least one lowercase letter';
                                        } else if (!value
                                            .contains(RegExp(r'[0-9]'))) {
                                          return 'Password must contain at least one digit';
                                        } else if (!value.contains(RegExp(
                                            r'(?=.*?[!@#\$&*~]).{8,}$'))) {
                                          return 'Password must contain at least one special character';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    right: 10,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                      icon: Icon(_obscurePassword == true
                                          ? Ionicons.eye
                                          : Ionicons.eye_off),
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
                            ArinaButton(
                              text: 'Log in',
                              isLoading: _isLoading,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _login(
                                      email: _email.text,
                                      password: _password.text);
                                }
                              },
                            ),

                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Don\'t have an account? ',
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
                                                const SignUp()),
                                      );
                                    },
                                    child: const Text(
                                      'SIGN UP',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
