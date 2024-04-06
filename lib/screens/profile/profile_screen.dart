import 'package:arina/constants/constants.dart';
import 'package:arina/providers/auth_provider.dart';
import 'package:arina/providers/profile_provider.dart';
import 'package:arina/routes/bottom_nav.dart';
import 'package:arina/shared/app_scaffold.dart';
import 'package:arina/shared/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileProvider>(context, listen: false).fetchProfile();

    return AppScaffold(
      body: Consumer<ProfileProvider>(builder: (context, profileProvider, _) {
        return SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50, top: 25, bottom: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: profileProvider.picture.isEmpty
                        ? const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('assets/images/person/man2.jpg'))
                        : SizedBox(
                            width: 100,
                            height: 100,
                            child: CachedImage(
                              imageUrl: profileProvider.picture,
                              borderRadius: BorderRadius.circular(100),
                            )),
                  ),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${profileProvider.firstName} ${profileProvider.lastName}",
                              style: largeText),
                          Text(
                            profileProvider.email,
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                  itemCount: settingsTab.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.go(settingsTab[index]["route"]);
                      },
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
            ),
            Consumer<FireAuthProvider>(
              builder: (context, auth, child) {
                return TextButton.icon(
                    style: TextButton.styleFrom(
                      fixedSize: const Size(200, 50),
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
                    label: const Text("Log Out"));
              },
            )
          ],
        ));
      }),
      bottomNavigationBar: const BottomNav(index: 3),
    );
  }
}

List settingsTab = [
  {
    "route": "/profile/about",
    "leading": const Icon(Ionicons.person),
    "title": const Text('About', style: nlargeText),
    "subtitle": const Text('Name, email, picture', style: smallText),
    "trailing": const Icon(Ionicons.chevron_forward),
  },
  {
    "route": "/profile/contact",
    "leading": const Icon(Ionicons.call),
    "title": const Text('Contact', style: nlargeText),
    "subtitle": const Text('Phone number, address', style: smallText),
    "trailing": const Icon(Ionicons.chevron_forward),
  },
  {
    "route": "/profile/terms",
    "leading": const Icon(Icons.policy),
    "title": const Text('Terms & Policy', style: nlargeText),
    "subtitle":
        const Text('Terms, policy, license & agreement', style: smallText),
    "trailing": const Icon(Ionicons.chevron_forward),
  },
];
