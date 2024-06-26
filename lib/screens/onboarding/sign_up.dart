// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:homeradar/constants/constants.dart';
import 'package:homeradar/models/profile_model.dart';

import 'package:homeradar/providers/auth_provider.dart';
import 'package:homeradar/screens/onboarding/components/forms_header.dart';
import 'package:homeradar/screens/onboarding/login.dart';
import 'package:homeradar/widgets/homeradar_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
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
                              'First Name',
                              style: TextStyle(
                                color: Color(0xFF909090),
                                fontSize: 14,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextFormField(
                              controller: _firstName,
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
                              'Last Name',
                              style: TextStyle(
                                color: Color(0xFF909090),
                                fontSize: 14,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextFormField(
                              controller: _lastName,
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
                            // PASSWORD
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

                            // BUTTON

                            Consumer<FireAuthProvider>(
                              builder: (BuildContext context, auth, child) {
                                return HomeRadarButton(
                                  text: 'Sign Up',
                                  isLoading: auth.isLoading,
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      bool success = await auth.register(
                                        email: _email.text,
                                        password: _password.text,
                                      );
                                      if (success) {
                                        try {
                                          firestore
                                              .collection("users")
                                              .doc(auth.currentUser!.uid)
                                              .set(
                                                ProfileModel(
                                                  firstName: _firstName.text,
                                                  lastName: _lastName.text,
                                                  email: _email.text,
                                                ).toFirestore(),
                                              );
                                        } catch (e) {
                                          log(e.toString());
                                        }
                                        context.go("/login");
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                            "Verification email sent. Check your inbox or spam folder",
                                          )),
                                        );
                                      } else {
                                        showSnack(context, auth.errorMessage);
                                      }
                                    }
                                  },
                                );
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
                                                const LogIn()),
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
