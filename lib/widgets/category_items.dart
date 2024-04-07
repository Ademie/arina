import 'package:arina/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryItem extends StatelessWidget {
  final String svgAsset;
  final String label;
  final Color containerColor;
  final Color labelColor;

  const CategoryItem({
    super.key,
    required this.svgAsset,
    required this.label,
    this.containerColor = const Color(0xFFF5F5F5),
    this.labelColor = const Color(0xFF999999),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => SearchScreen(query: svgAsset)));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 12.5),
            decoration: ShapeDecoration(
              color: containerColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: SvgPicture.asset('assets/svg/$svgAsset.svg'),
          ),
          Text(
            label,
            style: TextStyle(
              color: labelColor,
              fontSize: 14,
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}
