import 'package:arina/providers/owner_provider.dart';
import 'package:arina/screens/chat/widgets/chat_body.dart';
import 'package:arina/screens/chat/widgets/send_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.author,
    required this.propertyID,
    required this.userID,
  });

  final String author;
  final String propertyID;
  final String userID;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    final firestore = FirebaseFirestore.instance;

    final getMessages = FirebaseFirestore.instance
        .collection('chats')
        .where('propertyId', isEqualTo: widget.propertyID)
        .where('ownerId', isEqualTo: widget.author)
        .where('userId', isEqualTo: widget.userID)
        .orderBy('timestamp', descending: false)
        .snapshots();

    return Consumer<OwnerProvider>(builder: (context, ownerProvider, _) {
      ownerProvider.fetchOwner(widget.author);
      return Scaffold(
        appBar: AppBar(
          title: Text("${ownerProvider.firstName} ${ownerProvider.lastName}"),
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
              SliverToBoxAdapter(
                  child: ChatBody(
                getMessages: getMessages,
                ownerID: widget.author,
                userID: widget.userID,
              )),
              SliverToBoxAdapter(
                  child: SendBar(
                messageController: messageController,
                firestore: firestore,
                propertyID: widget.propertyID,
                ownerID: widget.author,
                userID: widget.userID,
              )),
            ],
          ),
        ),
      );
    });
  }
}
