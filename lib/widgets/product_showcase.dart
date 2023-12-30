import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductShowcase extends StatelessWidget {
  const ProductShowcase({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 449,
          height: 455,
          margin: const EdgeInsets.only(
            left: 52,
          ),
          decoration: const BoxDecoration(
            borderRadius:
                BorderRadius.only(bottomLeft: Radius.circular(50)),
            image: DecorationImage(
              image: AssetImage('assets/images/products/product-stand.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          left: 32,
          top: 53,
          child: GestureDetector(
            onTap: () {},
            child: Container(
                width: 42,
                height: 42,
                padding: const EdgeInsets.all(10),
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
                child: SvgPicture.asset('assets/svg/back-arrow.svg')),
          ),
        ),
        // ROUND RECTANGLE
        Positioned(
            left: 22,
            top: 149,
            child: Container(
              width: 64,
              height: 192,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x338A959E),
                    blurRadius: 40,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: SizedBox(
                width: 34,
                height: 34,
                child: Stack(
                  children: [
                    Positioned(
                      left: 15,
                      top: 50,
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF909090),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 55,
                      child: SvgPicture.asset("assets/svg/ar.svg"),
                    ),
                    Positioned(
                      left: 32,
                      top: 85,
                      child: Container(
                        height: 70,
                        width: 1,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFBDBDBD),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2)),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 22,
                      top: 155,
                      child: Text(
                        'A R',
                        style: TextStyle(
                          color: Color(0xFF303030),
                          fontFamily: 'Gelasio',
                          height: 0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ))
      ],
    );
  }
}