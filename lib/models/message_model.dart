import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String message;
  String senderId;
  String receiverId;
  Timestamp timestamp;

  MessageModel({
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.timestamp,
  });

  factory MessageModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return MessageModel(
      message: data?["message"],
      senderId: data?["senderId"],
      receiverId: data?["receiverId"],
      timestamp: data?["timestamp"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (message.isNotEmpty) "message": message,
      if (senderId.isNotEmpty) "senderId": senderId,
      if (receiverId.isNotEmpty) "receiverId": receiverId,
      "timestamp": timestamp,
    };
  }
}
