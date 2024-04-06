import 'package:arina/constants/constants.dart';
import 'package:arina/screens/products/widgets/image_dialog.dart';
import 'package:arina/shared/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';

class ProductShowcase extends StatelessWidget {
  const ProductShowcase({
    super.key,
    required this.mainImageURL,
    this.otherImages,
    required this.address,
  });
  final String mainImageURL;
  final List<dynamic>? otherImages;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // MAIN IMAGE
        GestureDetector(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (_) => ImageDialog(
                otherImages: otherImages,
                mainImageURL: mainImageURL,
              ),
            );
          },
          child: Container(
            width: 449,
            height: 410,
            margin: const EdgeInsets.only(
              left: 52,
            ),
            decoration: const BoxDecoration(
              boxShadow: [boxshadow],
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
            ),
            child: CachedImage(
              imageUrl: mainImageURL,
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(50)),
            ),
          ),
        ),
        Positioned(
          left: 32,
          top: 53,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                width: 42,
                height: 42,
                padding: const EdgeInsets.all(10),
                decoration: ShapeDecoration(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x338A959E),
                      blurRadius: 40,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: SvgPicture.asset('assets/svg/back-arrow.svg')),
          ),
        ),
        // BOTTOM OVERLAY
        Positioned(
            left: 52,
            bottom: 0,
            child: Container(
              height: 80,
              width: 449,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(50)),
                color: Color.fromARGB(130, 9, 9, 9),
              ),
            )),
        // BOTTOM INFO
        Positioned(
          left: 90,
          bottom: 20,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SizedBox(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          width: 37,
                          height: 37,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x338A959E),
                                blurRadius: 40,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: const Icon(Ionicons.location)),
                      SizedBox(
                        width: 250,
                        child: Text(
                          address,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                             height: 0,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
