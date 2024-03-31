import 'package:arina/constants/constants.dart';
import 'package:arina/models/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SavedProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _homes = [];
  List<Map<String, dynamic>> get homes => List.of(_homes);
  final ref = FirebaseFirestore.instance
      .collection("users")
      .doc(currentUserID)
      .withConverter(
        fromFirestore: ProfileModel.fromFirestore,
        toFirestore: (ProfileModel profileModel, _) =>
            profileModel.toFirestore(),
      );

  Future<void> add(Map<String, dynamic> home) async {
    String homeId = home["propertyID"];
    int existingIndex = _homes
        .indexWhere((existingHome) => existingHome['propertyID'] == homeId);
    if (existingIndex != -1) {
      List existValue = [_homes[existingIndex]];
      final updates = <String, dynamic>{
        "saved": FieldValue.arrayRemove(existValue)
      };
      ref.update(updates);
      _homes.removeAt(existingIndex);
      notifyListeners();
    } else {
      _homes.add(home);
      ref.update({
        "saved": _homes,
      });
      notifyListeners();
    }
  }

  void removeAll() {
    _homes.clear;
    notifyListeners();
  }

  Future<void> getSaved() async {
    try {
      final docSnap = await ref.get();
      final profileData = docSnap.data();
      if (profileData != null) {
        // _homes = profileData.saved!;
        notifyListeners();
      } else {
        print("No such document.");
      }
    } catch (e) {}
  }
}
