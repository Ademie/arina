import 'package:arina/firebase_options.dart';
import 'package:arina/providers/address_provider.dart';
import 'package:arina/providers/auth_provider.dart';
import 'package:arina/providers/owner_provider.dart';
import 'package:arina/providers/profile_provider.dart';
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
  late final OwnerProvider ownerProvider;
  late final ProfileProvider profileProvider;
  
  late final AddressProvider addressProvider;
  late final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  void initState() {
    fireAuthProvider = FireAuthProvider();
    savedProvider = SavedProvider();
    ownerProvider = OwnerProvider();
    profileProvider = ProfileProvider();
    
    addressProvider = AddressProvider();
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
        ChangeNotifierProvider<OwnerProvider>(
          create: (context) => ownerProvider,
        ),
        ChangeNotifierProvider<ProfileProvider>(
          create: (context) => profileProvider,
        ),
     
        ChangeNotifierProvider<SavedProvider>(
          create: (context) => savedProvider,
        ),
        ChangeNotifierProvider<AddressProvider>(
          create: (context) => addressProvider,
        ),
      ],
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: routeProvider.routerConfig,
        );
      },
    );
  }
}
