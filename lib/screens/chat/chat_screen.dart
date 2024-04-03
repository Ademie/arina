import 'package:arina/screens/chat/widgets/chat_body.dart';
import 'package:arina/screens/chat/widgets/send_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController messageContent = TextEditingController();
    final firestore = FirebaseFirestore.instance;
    final getMessages = firestore
        .collection("messages")
        .orderBy('timestamp', descending: false)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('James Smith'),
        scrolledUnderElevation: 0,
      ),
      body: Form(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFF303030),
                ),
                child: const Text(
                  'Thank you for your interest in this listing. Your inspection date has been scheduled for the 10th of March, more information is been sent to your mail. You can ask any questions you want from the sender but please DO NOT make any payment till you confirm the PROPERTY.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SliverToBoxAdapter(child: ChatBody(getMessages: getMessages)),
            SliverToBoxAdapter(
                child: SendBar(
                    messageContent: messageContent, firestore: firestore)),
          ],
        ),
      ),
    );
  }
}
