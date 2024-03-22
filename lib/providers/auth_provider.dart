import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireAuthProvider extends ChangeNotifier {
  bool isLoading = false;
  String errorMessage = "";

  // init firebase auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // create a user from firebase auth
  User? get currentUser => _firebaseAuth.currentUser;

  Future<bool> register(
      {required String email, required String password}) async {
    try {
      isLoading = true;
      notifyListeners();
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    
      isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        errorMessage = "The account already exists for that email.";
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
    }
    return true;
  }

// Login
  Future<bool> login({required String email, required String password}) async {
    try {
      isLoading = true;
      notifyListeners();
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        errorMessage = "Email or password is incorrect";
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
    }
    return true;
  }

  // log out
  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      notifyListeners();
      return false;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }
}
