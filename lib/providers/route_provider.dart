import 'package:arina/data/data.dart';
import 'package:arina/providers/auth_provider.dart';
import 'package:arina/screens/home/home_screen.dart';
import 'package:arina/screens/onboarding/login.dart';
import 'package:arina/screens/onboarding/sign_up.dart';
import 'package:arina/screens/profile/profile_screen.dart';
import 'package:arina/screens/saved/saved_screen.dart';
import 'package:arina/screens/splash/splash_screen.dart';
import 'package:arina/screens/upload/upload_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteProvider extends ChangeNotifier {
  final FireAuthProvider fireAuthProvider;
  final GlobalKey<NavigatorState> navigatorKey;
  late final GoRouter _router;
  final firestore = FirebaseFirestore.instance;

  GoRouter get routerConfig => _router;

  RouteProvider(this.fireAuthProvider, this.navigatorKey) {
    _router = GoRouter(
      refreshListenable: fireAuthProvider,
      navigatorKey: navigatorKey,
      routes: [
        GoRoute(
          name: "10thHomes",
          path: "/",
          builder: (context, state) => fireAuthProvider.currentUser != null
              ? const HomeScreen()
              : const SplashScreen(),
        ),
        GoRoute(
          path: "/home",
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: "/upload",
          builder: (context, state) => const UploadScreen(),
        ),
        GoRoute(
          path: "/saved",
          builder: (context, state) => SavedScreen(products: productData),
        ),
        GoRoute(
          path: "/profile",
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
            path: "/splash", builder: (context, state) => const SplashScreen()),
        GoRoute(path: "/signup", builder: (context, state) => const SignUp()),
        GoRoute(path: "/login", builder: (context, state) => const LogIn())
      ],
    );
  }
}
