import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  String firstName;
  String lastName;
  String email;
  String? phone;
  String? address;
  String? picture;
  String? adEmail;
  String? homePhone;
  List<dynamic>? saved;

  ProfileModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.address,
    this.picture,
    this.adEmail,
    this.homePhone,
    this.saved,
  });

  factory ProfileModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ProfileModel(
      firstName: data?["firstName"],
      lastName: data?["lastName"],
      email: data?["email"],
      phone: data?["phone"],
      address: data?["address"],
      picture: data?["picture"],
      adEmail: data?["adEmail"],
      homePhone: data?["homePhone"],
      saved: data?["saved"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (firstName.isNotEmpty) "firstName": firstName,
      if (lastName.isNotEmpty) "lastName": lastName,
      if (email.isNotEmpty) "email": email,
      "phone": phone ?? "",
      "address": address ?? "",
      "picture": picture ?? "",
      "adEmail": adEmail ?? "",
      "homePhone": homePhone ?? "",
      "saved": saved ?? []
    };
  }
}
