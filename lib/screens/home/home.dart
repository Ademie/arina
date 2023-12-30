import 'package:arina/data/data.dart';
import 'package:arina/widgets/category_items.dart';
import 'package:arina/widgets/products_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 21.87,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset("assets/svg/search.svg"),
                  const Column(
                    children: [
                      Text(
                        'Best shopping\n',
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
                  SvgPicture.asset("assets/svg/cart.svg"),
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
                  CategoryItem(svgAsset: 'chair', label: 'Chair'),
                  CategoryItem(svgAsset: 'table', label: 'Table'),
                  CategoryItem(svgAsset: 'sofa', label: 'ArmChair'),
                  CategoryItem(svgAsset: 'bed', label: 'Bed'),
                  CategoryItem(svgAsset: 'sofa', label: 'ArmChair'),
                ],
              ),
            ),
            // PRODUCTS LIST

            Container(
              height: 600,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ProductGridView(products: products),
            )
          ],
        ),
      )),
    );
  }
}
