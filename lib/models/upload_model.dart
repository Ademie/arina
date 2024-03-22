import 'package:cloud_firestore/cloud_firestore.dart';

class UploadModel {
  String title;
  String propAddress;
  String description;
  String duration;
  String rent;
  String security;
  String service;
  String total;

  UploadModel({
    required this.title,
    required this.propAddress,
    required this.description,
    required this.duration,
    required this.rent,
    required this.security,
    required this.service,
    required this.total,
  });

  factory UploadModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UploadModel(
      title: data?["title"],
      propAddress: data?["propAddress"],
      description: data?["description"],
      duration: data?["duration"],
      rent: data?["rent"],
      security: data?["security"],
      service: data?["service"],
      total: data?["total"]
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title.isNotEmpty) "title": title,
      if (propAddress.isNotEmpty) "propAddress": propAddress,
      if (description.isNotEmpty) "description": description,
      if (duration.isNotEmpty) "duration": duration,
      if (rent.isNotEmpty) "rent": rent,
      if (security.isNotEmpty) "security": security,
      if (service.isNotEmpty) "service": service,
      if (total.isNotEmpty) "total": total,
    };
  }
}
