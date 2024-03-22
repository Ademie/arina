import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class BottomNav extends StatelessWidget {
  final int index;
  const BottomNav({super.key, required int index})
      : index = index > 4 ? 0 : index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go("/home");
            return;
          case 1:
            context.go("/upload");
            return;
          case 2:
            context.go("/saved");
            return;
          case 3:
            context.go("/profile");
            return;
        }
      },
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/svg/home.svg',
            height: 24.0,
            width: 24.0,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/svg/plus.svg',
            height: 24.0,
            width: 24.0,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/svg/marker.svg',
            height: 24.0,
            width: 24.0,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/svg/profile.svg',
            height: 24.0,
            width: 24.0,
          ),
          label: '',
        ),
      ],
    );
  }
}
