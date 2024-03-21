import 'dart:developer';

import 'package:arina/constants/constants.dart';
import 'package:arina/screens/entry.dart';
import 'package:arina/screens/onboarding/components/forms_header.dart';
import 'package:arina/screens/onboarding/login.dart';
import 'package:arina/widgets/arina_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isLoading = false;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _cpassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _register(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
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
      if (e.code == 'weak-password') {
        errorMessage = "The password provided is too weak.";
        setState(() {
          _isLoading = true;
        });
        Future.delayed(const Duration(seconds: 2), () {
          showSnack(context, errorMessage);
          setState(() {
            _isLoading = false;
          });
        });
      } else if (e.code == 'email-already-in-use') {
        errorMessage = "The account already exists for that email.";
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
                              'Name',
                              style: TextStyle(
                                color: Color(0xFF909090),
                                fontSize: 14,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextFormField(
                              controller: _name,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter some text";
                                } else if (value.trim().length < 3) {
                                  return "Please enter a longer name";
                                }
                                return null;
                              },
                            ),
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
                            TextFormField(
                              controller: _email,
                              validator: (value) {
                                bool isEmailValid(String email) {
                                  String emailPattern =
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                  RegExp regExp = RegExp(emailPattern);
                                  return regExp.hasMatch(value!);
                                }

                                if (isEmailValid(value!) != true) {
                                  return "Please enter a valid email";
                                }

                                return null;
                              },
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
                                      obscureText: true,
                                      controller: _password,
                                      autocorrect: false,
                                      enableSuggestions: false,
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
                                  SizedBox(
                                    width: 400,
                                    height: 40,
                                    child: TextFormField(
                                      obscureText: true,
                                      autocorrect: false,
                                      enableSuggestions: false,
                                      controller: _cpassword,
                                      validator: (value) {
                                        if (value != _password.text) {
                                          return "Passwords do not match!";
                                        }
                                        return null;
                                      },
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
                              isLoading: _isLoading,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _register(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
