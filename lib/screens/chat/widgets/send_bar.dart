import 'dart:developer';

import 'package:arina/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

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
              child: IconButton(
                onPressed: () async {
                  String messageText = messageController.text.trim();

                  if (messageText.isNotEmpty) {
                    try {
                      FirebaseFirestore.instance
                          .collection('chats')
                          .doc(propertyID)
                          .collection(ownerID)
                          .doc(userID)
                          .collection("message")
                          .add(
                            MessageModel(
                              message: messageText,
                              senderId: userID,
                              receiverId: ownerID,
                              timestamp: Timestamp.now(),
                            ).toFirestore(),
                          )
                          .then((_) => messageController.clear());
                    } catch (e) {
                      log("error sending message $e");
                    }
                  }
                },
                icon: const Icon(Ionicons.send),
              ),
            )
          ],
        ),
      ),
    );
  }
}
