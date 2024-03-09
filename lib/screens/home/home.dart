import 'package:arina/data/data.dart';
import 'package:arina/screens/search/search.dart';
import 'package:arina/widgets/category_items.dart';
import 'package:arina/widgets/products_list.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    iconSize: 30,
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Search(
                                    products: products,
                                  )));
                    },
                    icon: const Icon(Ionicons.search_outline)),
                const Column(
                  children: [
                    Text(
                      'Best Home Rentals\n',
                      style: TextStyle(
                          color: Color(0xFF909090),
                          fontSize: 18,
                          fontFamily: 'Gelasio',
                          fontWeight: FontWeight.w400,
                          height: 1),
                    ),
                    Text(
                      'EXPERIENCE',
                      style: TextStyle(
                        color: Color(0xFF232323),
                        fontSize: 18,
                        fontFamily: 'Gelasio',
                        fontWeight: FontWeight.w700,
                        height: 0.08,
                      ),
                    ),
                  ],
                ),
                IconButton(
                    iconSize: 30,
                    color: Colors.grey,
                    onPressed: () {},
                    icon: const Icon(
                      Ionicons.notifications_outline,
                    )),
              ],
            ),
          ),
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
            child: ProductGridView(products: products),
          )
        ],
      ),
    ));
  }
}
