import 'package:arina/firebase_options.dart';
import 'package:arina/providers/auth_provider.dart';
import 'package:arina/providers/route_provider.dart';
import 'package:arina/providers/saved_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final RouteProvider routeProvider;
  late final FireAuthProvider fireAuthProvider;
  late final SavedProvider savedProvider;
  late final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  void initState() {
    fireAuthProvider = FireAuthProvider();
    savedProvider = SavedProvider();
    routeProvider = RouteProvider(fireAuthProvider, navigatorKey);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RouteProvider>(
          create: (context) => routeProvider,
        ),
        ChangeNotifierProvider<FireAuthProvider>(
          create: (context) => fireAuthProvider,
        ),
        ChangeNotifierProvider<SavedProvider>(
          create: (context) => savedProvider,
        ),
      ],
      builder: (context, child) {
        return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: routeProvider.routerConfig);
      },
    );
  }
}





// home: Consumer<FireAuthProvider>(builder: (context, auth, _) {
      //   return StreamBuilder<User?>(
      //       stream: auth.authStateChanges,
      //       builder: (context, snapshot) {
      //         if (snapshot.connectionState == ConnectionState.waiting) {
      //           return const Center(
      //             child: CircularProgressIndicator(),
      //           );
      //         } else if (snapshot.hasData) {
      //           return const HomeScreen();
      //         } else {
      //           return const SplashScreen();
      //         }
      //       });
      // }),