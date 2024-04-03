import 'package:arina/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.body,
    this.title,
    required this.bottomNavigationBar,
  });

  final Widget? body;
  final Widget bottomNavigationBar;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          scrolledUnderElevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 21),
            child: IconButton(
                iconSize: 30,
                color: Colors.grey,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SearchScreen()));
                },
                icon: const Icon(Ionicons.search_outline)),
          ),
          title: Text(
            title ?? 'Profile',
            style: const TextStyle(
              color: Color(0xFF232323),
              fontSize: 22,
              fontFamily: 'Gelasio',
              fontWeight: FontWeight.w700,
              height: 0.08,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 21),
              child: IconButton(
                iconSize: 30,
                color: Colors.grey,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SearchScreen()));
                },
                icon: IconButton(
                    iconSize: 30,
                    color: Colors.grey,
                    onPressed: () {},
                    icon: const Icon(
                      Ionicons.notifications_outline,
                    )),
              ),
            )
          ]),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
