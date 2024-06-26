import 'dart:async';
import 'dart:developer';
import 'package:homeradar/models/profile_model.dart';
import 'package:homeradar/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  StreamSubscription<DocumentSnapshot<ProfileModel>>? _subscription;

  FireAuthProvider fireAuthProvider = FireAuthProvider();

  ProfileProvider() {
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      final ref = FirebaseFirestore.instance
          .collection("users")
          .doc(fireAuthProvider.currentUser!.uid)
          .withConverter(
            fromFirestore: ProfileModel.fromFirestore,
            toFirestore: (ProfileModel profileModel, _) =>
                profileModel.toFirestore(),
          );

      _subscription = ref.snapshots().listen((snapshot) {
        final profileData = snapshot.data();
        if (profileData != null) {
          _firstName = profileData.firstName;
          _lastName = profileData.lastName;
          _email = profileData.email;
          _phone = profileData.phone;
          _address = profileData.address;
          _picture = profileData.picture;
          notifyListeners();
        } else {
          log("No such document.");
        }
      });
    } catch (error) {
      log("Error fetching profile: $error");
    }
  }

  @override
  void dispose() {
    _subscription!.cancel();
    super.dispose();
  }
}
