import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


// class FireAuthProvider extends ChangeNotifier {
//   bool isLoading = false;
//   String errorMessage = "";

//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   User? get currentUser => _firebaseAuth.currentUser;

//   Future<bool> register(
//       {required String email, required String password}) async {
//     try {
//       isLoading = true;
//       errorMessage = ""; // Clear previous error messages
//       notifyListeners();

//       await _firebaseAuth.createUserWithEmailAndPassword(
//           email: email, password: password);

//       isLoading = false;
//       notifyListeners();
//       return true;
//     } on FirebaseAuthException catch (e) {
//       errorMessage = e.message ?? "An error occurred";
//       isLoading = false;
//       notifyListeners();
//       return false;
//     } catch (e) {
//       log(e.toString());
//       isLoading = false;
//       notifyListeners();
//       return false;
//     }
//   }

//   Future<bool> login({required String email, required String password}) async {
//     try {
//       isLoading = true;
//       errorMessage = ""; // Clear previous error messages
//       notifyListeners();

//       await _firebaseAuth.signInWithEmailAndPassword(
//           email: email, password: password);

//       isLoading = false;
//       notifyListeners();
//       return true;
//     } on FirebaseAuthException catch (e) {
//       errorMessage = e.message ?? "An error occurred";
//       isLoading = false;
//       notifyListeners();
//       return false;
//     } catch (e) {
//       log(e.toString());
//       isLoading = false;
//       notifyListeners();
//       return false;
//     }
//   }

//   Future<bool> signOut() async {
//     try {
//       await _firebaseAuth.signOut();
//       notifyListeners();
//       return true; // Return true on success
//     } catch (e) {
//       log(e.toString());
//       return false;
//     }
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class FireAuthProvider extends ChangeNotifier {
  bool isLoading = false;
  String errorMessage = "";

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<bool> register({required String email, required String password}) async {
    try {
      isLoading = true;
      errorMessage = ""; // Clear previous error messages
      notifyListeners();

      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      await user!.sendEmailVerification(); // Send verification email

      isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message ?? "An error occurred";
      isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      log(e.toString());
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      isLoading = true;
      errorMessage = ""; // Clear previous error messages
      notifyListeners();

      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (!user!.emailVerified) {
        errorMessage = "Please verify your email before logging in.";
        isLoading = false;
        notifyListeners();
        return false;
      }

      isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message ?? "An error occurred";
      isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      log(e.toString());
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      notifyListeners();
      return true; // Return true on success
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}

