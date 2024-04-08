import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {
  final String propertyId;
  final String ownerId;
  final String userId;

  ChatsScreen(
      {required this.propertyId, required this.ownerId, required this.userId});

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(widget.propertyId)
                  .collection(widget.ownerId)
                  .doc(widget.userId)
                  .collection("message")
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                final messages = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message =
                        messages[index].data() as Map<String, dynamic>;

                    bool isOwnerMessage = message['senderId'] == widget.ownerId;
                    bool isUserMessage = message['senderId'] == widget.userId;
                    return ListTile(
                      title: Text(message['message']),
                      subtitle: Text(
                        '${DateTime.fromMillisecondsSinceEpoch(message['timestamp'].millisecondsSinceEpoch)}',
                      ),
                      tileColor: isOwnerMessage
                          ? Colors.blueAccent
                          : Colors.greenAccent,
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration:
                        const InputDecoration(hintText: 'Type a message...'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    _sendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.propertyId)
          .collection(widget.ownerId)
          .doc(widget.userId)
          .collection("message")
          .add({
        'senderId': widget.userId,
        'receiverId': widget.ownerId,
        'message': messageText,
        'timestamp': Timestamp.now(),
      }).then((_) {
        _messageController.clear();
      }).catchError((error) {
        print('Error sending message: $error');
      });
    }
  }
}
