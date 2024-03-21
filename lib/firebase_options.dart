// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDED2wGbbKp5oxcwRryLZs24lQypK4VMhE',
    appId: '1:578425176222:web:eb5c4a7681fa57e3e7bb8f',
    messagingSenderId: '578425176222',
    projectId: 'thhomes-63a29',
    authDomain: 'thhomes-63a29.firebaseapp.com',
    storageBucket: 'thhomes-63a29.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCl3Lf2v1zkP0OAmVH8dNDx7onCBrain9o',
    appId: '1:578425176222:android:0c6aa0864a222228e7bb8f',
    messagingSenderId: '578425176222',
    projectId: 'thhomes-63a29',
    storageBucket: 'thhomes-63a29.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAiO4X3V4fhoXzwMROVFGfox_48XcQilhg',
    appId: '1:578425176222:ios:e02070f8d14802ffe7bb8f',
    messagingSenderId: '578425176222',
    projectId: 'thhomes-63a29',
    storageBucket: 'thhomes-63a29.appspot.com',
    iosBundleId: 'morningstar.arina',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAiO4X3V4fhoXzwMROVFGfox_48XcQilhg',
    appId: '1:578425176222:ios:52283ce7a074548de7bb8f',
    messagingSenderId: '578425176222',
    projectId: 'thhomes-63a29',
    storageBucket: 'thhomes-63a29.appspot.com',
    iosBundleId: 'morningstar.arina.RunnerTests',
  );
}
