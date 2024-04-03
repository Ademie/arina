import 'dart:developer';

import 'package:arina/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SendBar extends StatelessWidget {
  const SendBar({
    super.key,
    required this.messageContent,
    required this.firestore,
  });

  final TextEditingController messageContent;
  final FirebaseFirestore firestore;

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
                  controller: messageContent,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () async {
                  try {
                    firestore.collection("messages").add(
                          MessageModel(
                            messageContent: messageContent.text,
                            messageType: "receiver",
                            timestamp: Timestamp.now(),
                          ).toFirestore(),
                        );
                    messageContent.text = "";
                  } catch (e) {
                    log("An error occured $e");
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
