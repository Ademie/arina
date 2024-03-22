// import 'package:arina/data/data.dart';
// import 'package:arina/providers/route_provider.dart';
// import 'package:arina/screens/home/home_screen.dart';
// import 'package:arina/screens/profile/profile_screen.dart';
// import 'package:arina/screens/saved/saved_screen.dart';
// import 'package:arina/screens/upload/upload_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';

// class Entry extends StatefulWidget {
//   const Entry({super.key});

//   @override
//   State<Entry> createState() => _EntryState();
// }

// int selectedIndex = 0;

// class _EntryState extends State<Entry> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<BottomProvider>(builder: (context, bottomProvider, _) {
//       Widget screen = const HomeScreen();
//       switch (bottomProvider.selectedIndex) {
//         case 0:
//           screen = const HomeScreen();
//           break;
//         case 1:
//           screen = const UploadScreen();
//           break;
//         case 2:
//           screen = SavedScreen(products: productData);
//           break;
//         case 3:
//           screen = const ProfileScreen();
//           break;
//       }
//       return Scaffold(
//         body: screen,
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: bottomProvider.selectedIndex,
//           onTap: (index) {
//             bottomProvider.updateIndex(index);
//           },
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           items: [
//             BottomNavigationBarItem(
//               icon: SvgPicture.asset(
//                 'assets/svg/home.svg',
//                 height: 24.0,
//                 width: 24.0,
//               ),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: SvgPicture.asset(
//                 'assets/svg/plus.svg',
//                 height: 24.0,
//                 width: 24.0,
//               ),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: SvgPicture.asset(
//                 'assets/svg/marker.svg',
//                 height: 24.0,
//                 width: 24.0,
//               ),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: SvgPicture.asset(
//                 'assets/svg/profile.svg',
//                 height: 24.0,
//                 width: 24.0,
//               ),
//               label: '',
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }



// // class Entry extends StatefulWidget {
// //   const Entry({super.key});

// //   @override
// //   State<Entry> createState() => _EntryState();
// // }

// // int selectedIndex = 0;

// // class _EntryState extends State<Entry> {
// //   @override
// //   Widget build(BuildContext context) {
    
// //     List<Widget> screens = <Widget>[
// //       const HomeScreen(),
// //       const UploadScreen(),
// //       SavedScreen(products: productData),
// //       const ProfileScreen()
// //     ];

// //     void onItemTapped(int index) {
// //       setState(() {
// //         selectedIndex = index;
// //       });
// //     }

// //     return Scaffold(
// //       body: Center(child: screens.elementAt(selectedIndex)),
      
// //       bottomNavigationBar: BottomNavigationBar(
// //         items: [
// //           BottomNavigationBarItem(
// //             icon: SvgPicture.asset(
// //               'assets/svg/home.svg',
// //               height: 24.0,
// //               width: 24.0,
// //             ),
// //             label: '',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: SvgPicture.asset(
// //               'assets/svg/plus.svg',
// //               height: 24.0,
// //               width: 24.0,
// //             ),
// //             label: '',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: SvgPicture.asset(
// //               'assets/svg/marker.svg',
// //               height: 24.0,
// //               width: 24.0,
// //             ),
// //             label: '',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: SvgPicture.asset(
// //               'assets/svg/profile.svg',
// //               height: 24.0,
// //               width: 24.0,
// //             ),
// //             label: '',
// //           ),
// //         ],
// //         currentIndex: selectedIndex,
// //         onTap: onItemTapped,
// //         showSelectedLabels: false,
// //         showUnselectedLabels: false,
// //       ),
// //     );
// //   }
// // }
