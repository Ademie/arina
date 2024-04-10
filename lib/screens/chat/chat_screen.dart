import 'package:arina/providers/owner_provider.dart';
import 'package:arina/screens/chat/widgets/chat_body.dart';
import 'package:arina/screens/chat/widgets/send_bar.dart';
import 'package:arina/screens/chat/widgets/user_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 172.20.10.8

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.author,
    required this.propertyID,
    required this.userID,
    this.userFirstName,
    this.userLastName,
    this.userPicture,
  });

  final String author;
  final String propertyID;
  final String userID;
  final String? userFirstName;
  final String? userLastName;
  final String? userPicture;

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
      String ownerFirstName = ownerProvider.firstName;
      String ownerLastName = ownerProvider.lastName;
      String ownerPicture = ownerProvider.picture;
      String userFirstName = widget.userFirstName ?? "";
      String userLastName = widget.userLastName ?? "";
      String userPicture = widget.userPicture ?? "";

      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: widget.author == widget.userID
            ? AppBar(
                title: Text("$userFirstName $userLastName"),
                actions: [
                  Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: UserAvatar(picture: userPicture)),
                ],
                scrolledUnderElevation: 0,
              )
            : AppBar(
                title: Text("$ownerFirstName $ownerLastName"),
                actions: [
                  Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: UserAvatar(picture: ownerPicture)),
                ],
                scrolledUnderElevation: 0,
              ),
        body: Form(
          child: Column(
            children: [
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('chats')
                      .doc(
                          "${widget.propertyID} ${widget.author} ${FirebaseAuth.instance.currentUser!.uid}")
                      .get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.hasError) {
                      return const Text("An error occured");
                    }
                    final data = snapshot.data!.data();
                    String firstMessage = data?["firstMessage"];

                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 14),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF303030),
                      ),
                      child: Text(
                        firstMessage,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }),
              Flexible(
                child: ChatBody(
                  getMessages: getMessages,
                  ownerID: widget.author,
                  userID: widget.userID,
                ),
              ),
              SendBar(
                messageController: messageController,
                firestore: firestore,
                propertyID: widget.propertyID,
                ownerID: widget.author,
                userID: widget.userID,
              ),
            ],
          ),
        ),
      );
    });
  }
}
