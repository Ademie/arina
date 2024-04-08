import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String message;
  String userId;
  String ownerId;
  String propertyId;
  String? userFirstName;
  String? userLastName;
  String? userPicture;
  String senderId;
  Timestamp timestamp;

  MessageModel({
    required this.message,
    required this.userId,
    required this.ownerId,
    required this.propertyId,
    this.userFirstName,
    this.userLastName,
    this.userPicture,
    required this.senderId,
    required this.timestamp,
  });

  factory MessageModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return MessageModel(
      message: data?["message"],
      userId: data?["userId"],
      ownerId: data?["ownerId"],
      userFirstName: data?["userFirstName"],
      userLastName: data?["userLastName"],
      userPicture: data?["userPicture"],
      propertyId: data?["propertyId"],
      senderId: data?["senderId"],
      timestamp: data?["timestamp"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (message.isNotEmpty) "message": message,
      if (userId.isNotEmpty) "userId": userId,
      if (ownerId.isNotEmpty) "ownerId": ownerId,
      if (propertyId.isNotEmpty) "propertyId": propertyId,
      "userFirstName": userFirstName,
      "userLastName": userLastName,
      "userPicture": userPicture,
      if (senderId.isNotEmpty) "senderId": senderId,
      "timestamp": timestamp,
    };
  }
}
