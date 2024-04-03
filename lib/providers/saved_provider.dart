import 'package:arina/constants/constants.dart';
import 'package:arina/models/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SavedProvider extends ChangeNotifier {
  bool isSaved(Map<String, dynamic> home) {
    return _homes.any(
        (existingHome) => existingHome['propertyID'] == home['propertyID']);
  }

  final List<dynamic> _homes = [];
  List<dynamic> get homes => List.of(_homes);

  List<dynamic> _fireHomes = [];
  List<dynamic> get fireHomes => List.of(_fireHomes);

  final ref = FirebaseFirestore.instance
      .collection("users")
      .doc(currentUserID)
      .withConverter(
        fromFirestore: ProfileModel.fromFirestore,
        toFirestore: (ProfileModel profileModel, _) =>
            profileModel.toFirestore(),
      );
  Future<void> loadSavedProducts() async {
    final snapshot = await ref.get();
    final profileModel = snapshot.data();
    if (profileModel != null) {
      _fireHomes = profileModel.saved!;
      _homes.addAll(_fireHomes);
      notifyListeners();
    }
  }

  SavedProvider() {
    loadSavedProducts();
  }

  Future<void> add(Map<String, dynamic> home) async {
    String homeId = home["propertyID"];
    int existingIndex = _homes
        .indexWhere((existingHome) => existingHome['propertyID'] == homeId);

    if (existingIndex != -1) {
      List existValue = [_homes[existingIndex]];
      final delete = <String, dynamic>{
        "saved": FieldValue.arrayRemove(existValue)
      };
      await ref.update(delete);
      _homes.removeAt(existingIndex);
      _fireHomes.removeAt(existingIndex);
      notifyListeners();
    } else {
      _homes.add(home);
      _fireHomes.add(home);
      final updates = <String, dynamic>{
        "saved": FieldValue.arrayUnion([home])
      };
      await ref.update(updates);
      notifyListeners();
    }
  }

  void remove(Map<String, dynamic> home) {
    _homes.removeWhere(
        (existingHome) => existingHome['propertyID'] == home['propertyID']);
    notifyListeners();
  }

  Future<void> removeAll() async {
    _homes.clear();
    _fireHomes.clear();
    await ref.update({"saved": FieldValue.delete()});
    notifyListeners();
  }
}
