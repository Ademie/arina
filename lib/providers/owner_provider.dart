import 'dart:developer';

import 'package:arina/models/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OwnerProvider extends ChangeNotifier {
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;
  String? _address;
  String? _picture;

  String get firstName => _firstName ?? "";
  String get lastName => _lastName ?? "";
  String get email => _email ?? "";
  String get phone => _phone ?? "";
  String get address => _address ?? "";
  String get picture => _picture ?? "";

  fetchOwner(String author) async {
    final ref = FirebaseFirestore.instance
        .collection("users")
        .doc(author)
        .withConverter(
          fromFirestore: ProfileModel.fromFirestore,
          toFirestore: (ProfileModel profileModel, _) =>
              profileModel.toFirestore(),
        );
    final docSnap = await ref.get();
    final ownerData = docSnap.data();
    if (ownerData != null) {
      _firstName = ownerData.firstName;
      _lastName = ownerData.lastName;
      _picture = ownerData.picture;
      _phone = ownerData.phone;
      _email = ownerData.email;
      _address = ownerData.address;
      notifyListeners();
    } else {
      log("No such document.");
    }
  }
}
