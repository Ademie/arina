import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

List<String> images = [
  'assets/images/products/blue_house/blue_house1.jpeg',
  'assets/images/products/blue_house/blue_house2.jpeg',
  'assets/images/products/blue_house/blue_house3.jpeg'
];

class ImageDialog extends StatefulWidget {
  const ImageDialog({super.key});

  @override
  State<ImageDialog> createState() => _ImageDialogState();
}

int index = 1;

class _ImageDialogState extends State<ImageDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      index = 1;
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x338A959E),
                          blurRadius: 40,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: SvgPicture.asset('assets/svg/cancel.svg'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 450,
              child: PageView.builder(
                  itemCount: images.length,
                  onPageChanged: (value) {
                    setState(() {
                      index = value + 1;
                    });
                  },
                  pageSnapping: true,
                  itemBuilder: (context, position) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage(
                                images[position],
                              ),
                              fit: BoxFit.cover)),
                    );
                  }),
            ),
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Text(
                '$index/${images.length}',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
              ),
            )
          ],
        ));
  }
}

class ProductShowcase extends StatelessWidget {
  const ProductShowcase({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // MAIN IMAGE
        GestureDetector(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (_) => const ImageDialog(),
            );
          },
          child: Container(
            width: 449,
            height: 410,
            margin: const EdgeInsets.only(
              left: 52,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
              image: DecorationImage(
                image: AssetImage('assets/images/thumbnails/blue_house.jpeg'),
                fit: BoxFit.fill,
              ),
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
        // ROUND RECTANGLE AR
        Positioned(
            left: 22,
            top: 120,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Container()),
                );
              },
              child: Container(
                width: 64,
                height: 120,
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
                        top: 20,
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
                        top: 25,
                        child: SvgPicture.asset("assets/svg/ar.svg"),
                      ),
                      Positioned(
                        left: 32,
                        top: 55,
                        child: Container(
                          height: 35,
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
                        top: 90,
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
              ),
            )),
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
                color: Color.fromARGB(51, 82, 88, 92),
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
                        child: SvgPicture.asset('assets/svg/bedd.svg'),
                      ),
                      const Text(
                        '6 Bedroom',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 37,
                        height: 37,
                        margin: const EdgeInsets.only(right: 10),
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
                        child: SvgPicture.asset('assets/svg/bathroom.svg'),
                      ),
                      const Text(
                        '3 Bathroom',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
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
