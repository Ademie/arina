import 'package:arina/models/messages_model.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    List<ChatMessage> messages = [
      ChatMessage(messageContent: "Hello, James", messageType: "sender"),
      ChatMessage(
          messageContent: "Hello Olu thanks for showing interest",
          messageType: "receiver"),
      ChatMessage(
          messageContent:
              "Can you give me a more detailed description of the property location?",
          messageType: "sender"),
      ChatMessage(messageContent: "Yeah it is just behind the Shessy petrol station by the roadside.", messageType: "receiver"),
      ChatMessage(
          messageContent: "Oh, that's great. Thank you!", messageType: "sender"),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('James Smith'),
        scrolledUnderElevation: 0,
      ),
      body: Container(
        color: const Color.fromARGB(255, 249, 248, 248),
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
                  'Thank you for your interest in this listing. Your inspection date has been scheduled for the 10th of March, more information is been sent to your mail. You can ask any questions you want from the owner but please DO NOT make any payment till you confirm the PROPERTY.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SliverList.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 14),
                    child: Align(
                      alignment: (messages[index].messageType == "receiver"
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 250),
                        decoration: BoxDecoration(
                          
                          borderRadius: BorderRadius.circular(20),
                          color: (messages[index].messageType == "receiver"
                              ? Colors.grey.shade200
                              : const Color(0xFF303030)),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          messages[index].messageContent,
                          style: TextStyle(
                            fontSize: 15,
                            color: (messages[index].messageType == "receiver"
                                ? const Color(0xFF303030)
                                : Colors.grey.shade200),
                          ),
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
      bottomSheet: Container(
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
                  child: const TextField(
                    decoration: InputDecoration.collapsed(hintText: 'Message'),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle_outline_rounded),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
