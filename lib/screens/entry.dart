import 'package:arina/data/data.dart';
import 'package:arina/screens/home/home.dart';
import 'package:arina/screens/profile/profile.dart';
import 'package:arina/screens/saved/saved.dart';
import 'package:arina/screens/upload/upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Entry extends StatefulWidget {
  const Entry({super.key});

  @override
  State<Entry> createState() => _EntryState();
}

int selectedIndex = 0;

class _EntryState extends State<Entry> {
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = <Widget>[
      const Home(),
      Upload(),
      Saved(products: productData),
      const Profile()
    
    ];

    void onItemTapped(int index) {
      setState(() {
        selectedIndex = index;
       
      });
    }

    return Scaffold(
      body: Center(child: screens.elementAt(selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
