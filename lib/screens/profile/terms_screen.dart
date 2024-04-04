import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 32,
            )),
        title: const Text('Terms and Policy'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Policy for HomeRadar',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '1. Acceptance of Terms',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'By downloading, installing, or using the HomeRadar mobile app, you agree to be bound by these Terms and Policy. If you do not agree with any part of these terms, you may not use the app.',
            ),
            SizedBox(height: 16.0),
            Text(
              '2. Description of Service',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'HomeRadar is a mobile application designed to help users find rental homes in their region. Our app provides a user-friendly interface for searching, filtering, and viewing rental listings. Users can also save favorite listings, receive notifications, and contact property owners or agents directly through the app.',
            ),
            SizedBox(height: 16.0),
            Text(
              '3. Privacy Policy',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Your privacy is important to us. We collect and use personal information in accordance with our Privacy Policy. By using HomeRadar, you consent to the collection and use of your personal information as described in our Privacy Policy.',
            ),
            SizedBox(height: 16.0),
            Text(
              '4. User Conduct',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              '- You agree to use HomeRadar for lawful purposes only.',
            ),
            Text(
              '- You will not use the app to engage in any illegal activities or violate the rights of others.',
            ),
            Text(
              '- You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.',
            ),
            Text(
              '- You will not attempt to gain unauthorized access to any part of the app or its systems.',
            ),
            SizedBox(height: 16.0),
            Text(
              '5. Intellectual Property',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'All content and materials provided in HomeRadar, including but not limited to text, graphics, logos, images, and software, are owned by or licensed to HomeRadar and are protected by copyright and other intellectual property laws.',
            ),
            SizedBox(height: 16.0),
            Text(
              '6. Limitation of Liability',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'HomeRadar and its affiliates, officers, directors, employees, agents, and licensors shall not be liable for any direct, indirect, incidental, special, or consequential damages arising out of or in any way connected with the use or inability to use the app.',
            ),
            SizedBox(height: 16.0),
            Text(
              '7. Changes to Terms and Policy',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'We reserve the right to modify or update these Terms and Policy at any time without prior notice. Your continued use of HomeRadar after any changes constitutes acceptance of the updated terms.',
            ),
            SizedBox(height: 16.0),
            Text(
              '8. Contact Information',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'If you have any questions or concerns about these Terms and Policy, please contact us at contact@email.com.',
            ),
            SizedBox(height: 16.0),
            Text(
              'Thank you for using HomeRadar! We hope you find your dream rental home with us.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
