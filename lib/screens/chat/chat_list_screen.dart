import 'package:homeradar/screens/chat/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_screen.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({
    super.key,
    required this.author,
    required this.propertyID,
  });

  final String author;
  final String propertyID;

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  String toTitleCase(String text) {
    if (text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('propertyId', isEqualTo: widget.propertyID)
            .where('ownerId', isEqualTo: widget.author)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text("No messages yet"),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
            );
          }
          final messages = snapshot.data!.docs;

          // Group messages by userId
          final groupedMessages = groupMessages(messages);

          return ListView.builder(
            itemCount: groupedMessages.length,
            itemBuilder: (context, index) {
              final userId = groupedMessages.keys.elementAt(index);
              final latestMessage = groupedMessages[userId]![0];
              final userFirstName = latestMessage["userFirstName"];
              final userLastName = latestMessage["userLastName"];
              final userPicture = latestMessage["userPicture"];
              return Stack(
                children: [
                  ListTile(
                    leading: UserAvatar(
                      picture: userPicture ?? "",
                      width: 50,
                      height: 50,
                    ),
                    title: Text(
                        "${toTitleCase(userFirstName)} ${toTitleCase(userLastName)}"),
                    subtitle: Text(latestMessage['message']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            author: latestMessage['ownerId'],
                            propertyID: latestMessage['propertyId'],
                            userFirstName: userFirstName,
                            userLastName: userLastName,
                            userPicture: userPicture,
                            userID: userId,
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    left: 80,
                    right: 0,
                    child: Container(
                      height: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  // Function to group messages by userId
  Map<String, List<Map<String, dynamic>>> groupMessages(
      List<DocumentSnapshot> messages) {
    Map<String, List<Map<String, dynamic>>> groupedMessages = {};

    for (var message in messages) {
      final messageData = message.data() as Map<String, dynamic>;
      final userId = messageData['userId'];

      if (groupedMessages.containsKey(userId)) {
        groupedMessages[userId]!.add(messageData);
      } else {
        groupedMessages[userId] = [messageData];
      }
    }

    return groupedMessages;
  }
}
