import 'dart:developer';

import 'package:homeradar/models/message_model.dart';
import 'package:homeradar/providers/profile_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class SendBar extends StatelessWidget {
  const SendBar({
    super.key,
    required this.messageController,
    required this.firestore,
    required this.propertyID,
    required this.ownerID,
    required this.userID,
  });

  final TextEditingController messageController;
  final FirebaseFirestore firestore;
  final String propertyID;
  final String ownerID;
  final String userID;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: const Color.fromARGB(255, 239, 239, 239),
      child: Form(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 10,
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: TextFormField(
                  decoration:
                      const InputDecoration.collapsed(hintText: 'Message'),
                  controller: messageController,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Consumer<ProfileProvider>(
                  builder: (context, profileProvider, _) {
                return IconButton(
                  onPressed: () {
                    _sendMessage();
                  },
                  icon: const Icon(Ionicons.send),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    String messageText = messageController.text.trim();
    if (messageText.isEmpty) return;

    String currentUserID = FirebaseAuth.instance.currentUser!.uid;

    Future<void> sendMessage(String senderFirstName, String senderLastName,
        String senderPicture) async {
      try {
        await FirebaseFirestore.instance.collection('chats').add(
              MessageModel(
                message: messageText,
                ownerId: ownerID,
                userId: userID,
                propertyId: propertyID,
                userFirstName: senderFirstName,
                userLastName: senderLastName,
                userPicture: senderPicture,
                senderId: currentUserID,
                timestamp: Timestamp.now(),
              ).toFirestore(),
            );
        messageController.clear();
      } catch (error) {
        log('Error sending message: $error');
      }
    }

    // Fetch user details and send message
    if (currentUserID == ownerID) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .get()
          .then((userData) {
        String userFirstName = userData['firstName'];
        String userLastName = userData['lastName'];
        String userPicture = userData['picture'];
        sendMessage(userFirstName, userLastName, userPicture);
      }).catchError((error) {
        log('Error retrieving user details: $error');
      });
    } else {
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserID)
          .get()
          .then((userData) {
        String userFirstName = userData['firstName'];
        String userLastName = userData['lastName'];
        String userPicture = userData['picture'];
        sendMessage(userFirstName, userLastName, userPicture);
      }).catchError((error) {
        log('Error retrieving user details: $error');
      });
    }
  }
}
