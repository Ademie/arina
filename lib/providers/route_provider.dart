import 'package:homeradar/providers/auth_provider.dart';
import 'package:homeradar/screens/home/home_screen.dart';
import 'package:homeradar/screens/onboarding/login.dart';
import 'package:homeradar/screens/onboarding/sign_up.dart';
import 'package:homeradar/screens/profile/about_screen.dart';
import 'package:homeradar/screens/profile/contact_screen.dart';
import 'package:homeradar/screens/profile/profile_screen.dart';
import 'package:homeradar/screens/profile/terms_screen.dart';
import 'package:homeradar/screens/saved/saved_screen.dart';
import 'package:homeradar/screens/splash/splash_screen.dart';
import 'package:homeradar/screens/upload/upload_screen.dart';
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
      initialLocation: "/",
      routes: [
        GoRoute(
          name: "HomeRadar",
          path: "/",
          builder: (context, state) => fireAuthProvider.currentUser != null &&
                  fireAuthProvider.currentUser!.emailVerified
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
          builder: (context, state) => const SavedScreen(),
        ),
        GoRoute(
            name: "profile",
            path: "/profile",
            builder: (context, state) => const ProfileScreen(),
            routes: [
              GoRoute(
                name: "about",
                path: "about",
                builder: (context, state) => const AboutScreen(),
              ),
              GoRoute(
                name: "contact",
                path: "contact",
                builder: (context, state) => const ContactScreen(),
              ),
              GoRoute(
                name: "terms",
                path: "terms",
                builder: (context, state) => const TermsScreen(),
              ),
            ]),
        GoRoute(
            path: "/splash", builder: (context, state) => const SplashScreen()),
        GoRoute(path: "/signup", builder: (context, state) => const SignUp()),
        GoRoute(path: "/login", builder: (context, state) => const LogIn())
      ],
    );
  }
}
