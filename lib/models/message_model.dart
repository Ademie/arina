import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String messageContent;
  String messageType;
  Timestamp timestamp;

  MessageModel({
    required this.messageContent,
    required this.messageType,
    required this.timestamp,
  });

  factory MessageModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return MessageModel(
        messageContent: data?["messageContent"],
        messageType: data?["messageType"],
        timestamp: data?["timestamp"]);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (messageContent.isNotEmpty) "messageContent": messageContent,
      if (messageType.isNotEmpty) "messageType": messageType,
      "timestamp": timestamp
    };
  }
}
