import 'package:arina/constants/constants.dart';
import 'package:arina/widgets/arina_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  TextFormField(
                    // controller: _email,
                    decoration: InputDecoration(
                      hintText: "Phone Number(mobile)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    // controller: _email,
                    decoration: InputDecoration(
                      hintText: "Phone Number(home)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    // controller: _email,

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
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(25),
        child: ArinaButton(
          text: "Submit",
          width: 400,
          onPressed: () {},
        ),
      ),
    );
  }
}
