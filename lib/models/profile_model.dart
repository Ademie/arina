import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  String firstName;
  String lastName;
  String email;
  String password;
  String? phone;
  String? address;
  String? picture;
  // List<Map<String, dynamic>>? saved;
  // List<ProductModel>? saved;
  List<dynamic>? saved;

  ProfileModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.phone,
    this.address,
    this.picture,
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
      password: data?["password"],
      phone: data?["phone"],
      address: data?["address"],
      picture: data?["picture"],
      saved: data?["saved"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (firstName.isNotEmpty) "firstName": firstName,
      if (lastName.isNotEmpty) "lastName": lastName,
      if (email.isNotEmpty) "email": email,
      if (password.isNotEmpty) "password": password,
      "phone": phone ?? "",
      "address": address ?? "",
      "picture": picture ?? "",
      "saved": saved ?? []
    };
  }

}
