import 'package:arina/shared/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageDialog extends StatefulWidget {
  const ImageDialog({super.key, this.otherImages, this.mainImageURL});

  final List<dynamic>? otherImages;
  final String? mainImageURL;

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
                  itemCount: widget.otherImages?.length,
                  onPageChanged: (value) {
                    setState(() {
                      index = value + 1;
                    });
                  },
                  pageSnapping: true,
                  itemBuilder: (context, position) {
                    return CachedImage(imageUrl: widget.otherImages?[position]);
                  }),
            ),
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Text(
                '$index/${widget.otherImages?.length}',
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
