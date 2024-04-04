import 'package:arina/constants/constants.dart';
import 'package:arina/models/profile_model.dart';
import 'package:arina/widgets/arina_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  TextEditingController? _firstName;
  TextEditingController? _lastName;
  TextEditingController? _email;
  TextEditingController? _adEmail;
  String? firstName;
  String? lastName;
  String? email;
  String? adEmail;
  String? picture;
  bool hasAnyFieldChanged = false;

  final _formKey = GlobalKey<FormState>();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _firstName!.dispose();
    _lastName!.dispose();
    _email!.dispose();
    _adEmail!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userRef = firestore.collection("users").doc(currentUserID).get();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 32,
            )),
        title: const Text(
          "About",
          style: nlargeText,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: FutureBuilder(
              future: userRef,
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.hasError) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
                final data = snapshot.data!.data();
                firstName = data?["firstName"] ?? "";
                lastName = data?["lastName"] ?? "";
                email = data?["email"] ?? "";
                adEmail = data?["adEmail"] ?? "";
                _firstName = TextEditingController(text: firstName);
                _lastName = TextEditingController(text: lastName);
                _email = TextEditingController(text: email);
                _adEmail = TextEditingController(text: adEmail);
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 25.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: const Stack(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(
                                      'assets/images/person/man2.jpg'),
                                ),
                                Positioned(
                                  top: 0,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor:
                                        Color.fromARGB(67, 5, 5, 5),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: _firstName,
                          decoration: InputDecoration(
                            hintText: "First Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
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
                          height: 30,
                        ),
                        TextFormField(
                          controller: _lastName,
                          decoration: InputDecoration(
                            hintText: "Last Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
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
                          height: 30,
                        ),
                        TextFormField(
                          controller: _email,
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: "Email Address",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _adEmail,
                          decoration: InputDecoration(
                            hintText: "Additional Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              bool isEmailValid(String email) {
                                String emailPattern =
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                RegExp regExp = RegExp(emailPattern);
                                return regExp.hasMatch(value);
                              }

                              if (isEmailValid(value) != true) {
                                return "Please enter a valid email";
                              }
                            }

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(25),
        child: ArinaButton(
          text: "Submit",
          width: 400,
          onPressed: () {
            if (_firstName!.text != firstName ||
                _lastName!.text != lastName ||
                _email!.text != email ||
                _adEmail!.text != adEmail) {
              hasAnyFieldChanged = true;
            } else {
              hasAnyFieldChanged = false;
            }
            if (_formKey.currentState!.validate() && hasAnyFieldChanged) {
              try {
                firestore.collection("users").doc(currentUserID).set(
                    ProfileModel(
                      firstName: _firstName!.text,
                      lastName: _lastName!.text,
                      email: _email!.text,
                      adEmail: _adEmail!.text,
                      picture: picture,
                    ).toFirestore(),
                    SetOptions(merge: true));
                showSnack(context, "Profile updated successfully");
                context.pop();
              } catch (e) {
                showSnack(context, "An error occured $e");
              }
            }
          },
        ),
      ),
    );
  }
}
