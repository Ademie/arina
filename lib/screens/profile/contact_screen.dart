import 'package:arina/constants/constants.dart';
import 'package:arina/providers/auth_provider.dart';
import 'package:arina/widgets/arina_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  TextEditingController? _phone;
  TextEditingController? _homePhone;

  TextEditingController? _address;
  String? phone;
  String? homePhone;
  String? address;

  bool hasAnyFieldChanged = false;

  final _formKey = GlobalKey<FormState>();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  FireAuthProvider fireAuthProvider = FireAuthProvider();

  @override
  void dispose() {
    _phone!.dispose();
    _homePhone!.dispose();
    _address!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userRef = firestore.collection("users").doc(fireAuthProvider.currentUser?.uid).get();
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
          "Contact",
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
                phone = data?["phone"] ?? "";
                homePhone = data?["homePhone"] ?? "";
                address = data?["address"] ?? "";
                _phone = TextEditingController(text: phone);
                _homePhone = TextEditingController(text: homePhone);
                _address = TextEditingController(text: address);
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _phone,
                          decoration: InputDecoration(
                            hintText: "Phone Number(mobile)",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter some text";
                            } else if (value.trim().length < 3) {
                              return "Please enter a longer phone number";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _homePhone,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: "Phone Number(home)",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter some text";
                            } else if (value.trim().length < 3) {
                              return "Please enter a longer phone number";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _address,
                          decoration: InputDecoration(
                            hintText: "Residential Address",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(25),
        child: ArinaButton(
          text: "Submit",
          width: 400,
          onPressed: () {
            if (_phone!.text != phone ||
                _homePhone!.text != homePhone ||
                _address!.text != address) {
              hasAnyFieldChanged = true;
            } else {
              hasAnyFieldChanged = false;
            }
            if (_formKey.currentState!.validate() && hasAnyFieldChanged) {
              try {
                firestore.collection("users").doc(fireAuthProvider.currentUser?.uid).update({
                  'phone': _phone!.text,
                  'homePhone': _homePhone!.text,
                  'address': _address!.text,
                }).then((_) {
                  showSnack(context, "Profile updated successfully");
                  context.pop();
                }).catchError((e) {
                  showSnack(context, "Error updating profile $e");
                });
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
