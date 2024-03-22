import 'package:arina/data/data.dart';
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
      title: "ARINA",
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
                  CategoryItem(
                    svgAsset: 'star',
                    label: 'Popular',
                    labelColor: Color(0xFF232323),
                    containerColor: Color(0xFF303030),
                  ),
                  CategoryItem(svgAsset: 'sofa', label: 'New'),
                  CategoryItem(svgAsset: 'chair', label: 'Rent'),
                  CategoryItem(svgAsset: 'table', label: 'For Sale'),
                  CategoryItem(svgAsset: 'sofa', label: 'Shortlets'),
                  CategoryItem(svgAsset: 'bed', label: 'Resorts'),
                ],
              ),
            ),
            // PRODUCTS LIST
            Container(
              height: 600,
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
              child: ProductGridView(products: productData),
            )
          ],
        ),
      )),
      bottomNavigationBar: const BottomNav(index: 0),
    );
  }
}
