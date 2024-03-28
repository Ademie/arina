import 'package:arina/models/profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class ProfileProvider extends ChangeNotifier {
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

  Future<void> fetchProfile() async {
    try {
      final ref = FirebaseFirestore.instance
          .collection("users")
          .doc(_firebaseAuth.currentUser!.uid)
          .withConverter(
            fromFirestore: ProfileModel.fromFirestore,
            toFirestore: (ProfileModel profileModel, _) =>
                profileModel.toFirestore(),
          );
      final docSnap = await ref.get();
      final profileData = docSnap.data();
      if (profileData != null) {
        _firstName = profileData.firstName;
        _lastName = profileData.lastName;
        _email = profileData.email;
        _phone = profileData.phone;
        _address = profileData.address;
        _picture = profileData.picture;
        notifyListeners();
      } else {
        print("No such document.");
      }
    } catch (error) {
      print("Error fetching profile: $error");
    }
  }
}
