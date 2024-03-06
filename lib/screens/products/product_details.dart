import 'package:arina/widgets/arina_button.dart';
import 'package:arina/widgets/product_showcase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
        body: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            // PRODUCT IMAGE
            const ProductShowcase(),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        'Minimal Stand',
                        style: TextStyle(
                          color: Color(0xFF303030),
                          fontSize: 24,
                          fontFamily: 'Gelasio',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '\$ 50',
                        style: TextStyle(
                          color: Color(0xFF303030),
                          fontSize: 30,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SvgPicture.asset('assets/svg/plus.svg'),
                          const SizedBox(width: 15),
                          const Text(
                            '01',
                            style: TextStyle(
                              color: Color(0xFF232323),
                              fontSize: 18,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w600,
                              height: 0,
                              letterSpacing: 0.90,
                            ),
                          ),
                          const SizedBox(width: 15),
                          SvgPicture.asset('assets/svg/minus.svg'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // RATINGS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset('assets/svg/rating.svg'),
                      const SizedBox(
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '4.5',
                              style: TextStyle(
                                color: Color(0xFF303030),
                                fontSize: 18,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            Text(
                              '(50 reviews)',
                              style: TextStyle(
                                color: Color(0xFF808080),
                                fontSize: 14,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: Container())
                    ],
                  ),
                  // PRODUCT DESCRIPTION
                  Container(
                    margin: const EdgeInsets.only(top: 14, bottom: 20),
                    child: const Text(
                      'Minimal Stand is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home. ',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Color(0xFF5F5F5F),
                        fontSize: 14,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w300,
                        height: 0,
                      ),
                    ),
                  ),
        
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        padding: const EdgeInsets.all(18),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF0F0F0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: SvgPicture.asset("assets/svg/marker.svg"),
                      ),
                      ArinaButton(
                        text: 'Add to cart',
                        onPressed: () {},
                        width: 220,
                        height: 60,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
