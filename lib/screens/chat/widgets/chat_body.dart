import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({
    super.key,
    required this.getMessages,
  });

  final Stream<QuerySnapshot<Map<String, dynamic>>> getMessages;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: getMessages,
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
    
          final messages = snapshot.data!.docs;
          return SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.65,
            child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 14),
                    child: Align(
                      alignment: (messages[index]["messageType"] == "sender"
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 250),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (messages[index]["messageType"] == "sender"
                              ? Colors.grey.shade200
                              : const Color(0xFF303030)),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          messages[index]["messageContent"],
                          style: TextStyle(
                            fontSize: 15,
                            color: (messages[index]["messageType"] == "sender"
                                ? const Color(0xFF303030)
                                : Colors.grey.shade200),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          );
        });
  }
}

