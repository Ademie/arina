import 'package:arina/routes/bottom_nav.dart';
import 'package:arina/shared/app_scaffold.dart';
import 'package:arina/widgets/category_items.dart';
import 'package:arina/widgets/products_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "HOME RADAR",
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            // CATEGORIES
            Container(
              height: 150,
              width: 389,
              padding: const EdgeInsets.all(10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CategoryItem(svgAsset: 'apartment', label: 'Apartment'),
                  CategoryItem(svgAsset: 'duplex', label: 'Duplex'),
                  CategoryItem(svgAsset: 'bungalow', label: 'Bungalow'),
                  CategoryItem(svgAsset: 'villa', label: 'Villa'),
                  CategoryItem(svgAsset: 'penthouse', label: 'Pent House'),
                ],
              ),
            ),
            // PRODUCTS LIST
            Container(
              height: 600,
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
              child: const ProductGridView(),
            )
          ],
        ),
      )),
      bottomNavigationBar: const BottomNav(index: 0),
    );
  }
}
