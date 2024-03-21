import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  // init firebase auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // create a user from firebase auth
  User? get currentUser => _firebaseAuth.currentUser;

  // listen to auth changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // log out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
    }
  }
}
