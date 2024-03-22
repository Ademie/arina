import 'package:arina/constants/constants.dart';
import 'package:arina/providers/auth_provider.dart';
import 'package:arina/routes/bottom_nav.dart';
import 'package:arina/shared/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(left: 20, top: 25, bottom: 25),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Flexible(
                    flex: 1,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage('assets/images/person/man2.jpg'),
                    ),
                  ),
                  const Flexible(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Ademie Dave", style: largeText),
                          Text(
                            "adeisijola7@gmail.com",
                            style: smallText,
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(flex: 1, child: Container())
                ],
              ),
            ),
          ),
          SliverList.builder(
              itemCount: settingsTab.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 15),
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const [boxshadow],
                        color: Colors.white,
                      ),
                      child: ListTile(
                          leading: settingsTab[index]["leading"],
                          title: settingsTab[index]["title"],
                          subtitle: settingsTab[index]["subtitle"],
                          trailing: settingsTab[index]["trailing"])),
                );
              }),
          Consumer<FireAuthProvider>(
            builder: (context, auth, child) {
              return SliverToBoxAdapter(
                  child: TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF232323),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        shadowColor: const Color(0x3F303030),
                      ),
                      onPressed: () {
                        auth.signOut();
                        context.go("/login");
                        showSnack(context, "Sign Out Successfully");
                      },
                      icon: const Icon(Ionicons.log_out),
                      label: const Text("Log Out")));
            },
          )
        ],
      ),
      bottomNavigationBar: const BottomNav(index: 3),
    );
  }
}

List settingsTab = [
  {
    "leading": const Icon(Ionicons.person),
    "title": const Text('About', style: nlargeText),
    "subtitle": const Text('Name, email, password', style: smallText),
    "trailing": const Icon(Ionicons.chevron_forward),
  },
  {
    "leading": const Icon(Ionicons.call),
    "title": const Text('Contact', style: nlargeText),
    "subtitle": const Text('Phone number(s)', style: smallText),
    "trailing": const Icon(Ionicons.chevron_forward),
  },
  {
    "leading": const Icon(Ionicons.location),
    "title": const Text('Address', style: nlargeText),
    "subtitle": const Text('Location', style: smallText),
    "trailing": const Icon(Ionicons.chevron_forward),
  },
];
