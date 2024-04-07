import 'package:cloud_firestore/cloud_firestore.dart';

class UploadModel {
  String title;
  String description;
  String duration;
  String rent;
  String security;
  String service;
  String total;
  String author;
  String? propertyID;
  List<String> imagesURL;
  double latitude;
  double longitude;
  String addrDescription;

  UploadModel(
      {required this.title,
      required this.description,
      required this.duration,
      required this.rent,
      required this.security,
      required this.service,
      required this.total,
      required this.imagesURL,
      required this.author,
      this.propertyID,
      required this.latitude,
      required this.longitude,
      required this.addrDescription});

  factory UploadModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UploadModel(
        title: data?["title"],
        description: data?["description"],
        duration: data?["duration"],
        rent: data?["rent"],
        security: data?["security"],
        service: data?["service"],
        total: data?["total"],
        imagesURL: data?["imagesURL"],
        author: data?["author"],
        propertyID: data?["propertyID"],
        latitude: data?["latitude"],
        longitude: data?["longitude"],
        addrDescription: data?["addrDescription"]);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title.isNotEmpty) "title": title,
      if (description.isNotEmpty) "description": description,
      if (duration.isNotEmpty) "duration": duration,
      if (rent.isNotEmpty) "rent": rent,
      if (security.isNotEmpty) "security": security,
      if (service.isNotEmpty) "service": service,
      if (total.isNotEmpty) "total": total,
      if (imagesURL.isNotEmpty) "imagesURL": imagesURL,
      if (author.isNotEmpty) "author": author,
      "propertyID": propertyID ?? "",
      if (!latitude.isNaN) "latitude": latitude,
      if (!longitude.isNaN) "longitude": longitude,
      if (addrDescription.isNotEmpty) "addrDescription": addrDescription
    };
  }
}
