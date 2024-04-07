import 'package:arina/providers/saved_provider.dart';
import 'package:arina/screens/inspection/inspect_screen.dart';
import 'package:arina/screens/products/product_details.dart';
import 'package:arina/widgets/arina_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ProductDetailsBottom extends StatelessWidget {
  // const ProductDetailsBottom({
  //   super.key,
  //   required this.data,
  //   required this.widget,
  // });

  const ProductDetailsBottom({
    Key? key,
    required this.data,
    required this.widget,
  }) : super(key: key);

  final Map<String, dynamic>? data;
  final ProductDetails widget;

  @override
  Widget build(BuildContext context) {
    return Consumer<SavedProvider>(builder: (context, saveHome, _) {
      bool isSavedProduct = data != null && saveHome.isSaved(data!);

      return Container(
        height: 150,
        color: Colors.white,
        padding: const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                saveHome.add(data!);
              },
              child: Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(18),
                decoration: ShapeDecoration(
                  color: const Color(0xFFF0F0F0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: isSavedProduct
                    ? SvgPicture.asset("assets/svg/marker-filled.svg")
                    : SvgPicture.asset("assets/svg/marker.svg"),
              ),
            ),
            ArinaButton(
              text: 'Book Inspection',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InspectScreen(
                              propertyID: widget.propertyID,
                            )));
              },
              width: 220,
              height: 60,
            )
          ],
        ),
      );
    });
  }
}
