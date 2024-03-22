// import 'package:arina/data/data.dart';
// import 'package:arina/screens/entry.dart';
// import 'package:arina/screens/home/home_screen.dart';
// import 'package:arina/screens/onboarding/login.dart';
// import 'package:arina/screens/onboarding/sign_up.dart';
// import 'package:arina/screens/profile/profile_screen.dart';
// import 'package:arina/screens/saved/saved_screen.dart';
// import 'package:arina/screens/upload/upload_screen.dart';
// import 'package:flutter/material.dart';

// class RouteGenerator {
//   static Route<dynamic> generateRoutes(RouteSettings settings) {
//     switch (settings.name) {
//       case "/":
//         return MaterialPageRoute(builder: (context) => const Entry());
//       case "/home":
//         return MaterialPageRoute(builder: (context) => const HomeScreen());
//       case "/upload":
//         return MaterialPageRoute(builder: (context) => const UploadScreen());
//       case "/saved":
//         return MaterialPageRoute(
//             builder: (context) => SavedScreen(products: productData));
//       case "/profile":
//         return MaterialPageRoute(builder: (context) => const ProfileScreen());
//       case "/login":
//         return MaterialPageRoute(builder: (context) => const LogIn());
//       case "/signup":
//         return MaterialPageRoute(builder: (context) => const SignUp());

//       default:
//         return MaterialPageRoute(
//             builder: (context) => Scaffold(
//                   body: Center(
//                     child: Text("Not found ${settings.name}"),
//                   ),
//                 ));
//     }
//   }
// }
