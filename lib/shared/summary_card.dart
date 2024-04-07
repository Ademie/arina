import 'package:arina/shared/cached_image.dart';
import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,
    this.title,
    this.imageURL,
    this.propAddress,
    this.rent,
    this.goTo,
    this.remove,
    this.removeProd,
  });
  final String? title;
  final String? imageURL;
  final String? propAddress;
  final String? rent;
  final Function()? goTo;
  final bool? remove;
  final Widget? removeProd;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(25),
      color: Colors.white,
      child: GestureDetector(
        onTap: goTo,
        child: Stack(
          children: [
            SizedBox(
              height: 150,
              child: Row(
                children: [
                  // SUMMARY IMAGE
                  Container(
                    height: 400,
                    width: 170,
                    margin: const EdgeInsets.only(right: 20),
                    child: CachedImage(
                      imageUrl: imageURL!,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                  ),

                  // SUMMARY TEXT
                  SizedBox(
                    height: 400,
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title ?? 'James Villa',
                          softWrap: true,
                          maxLines: 3,
                          style: const TextStyle(
                            color: Color(0xFF303030),
                            fontSize: 18,
                            fontFamily: 'Gelasio',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        Text(
                          propAddress ??
                              '14, James Kowope Street, Akure Ondo, Nigeria',
                          softWrap: true,
                          maxLines: 3,
                          style: const TextStyle(
                            color: Color.fromARGB(197, 48, 48, 48),
                            fontSize: 12,
                            fontFamily: 'Nunito Sans',
                            height: 0,
                          ),
                        ),
                        Text(
                          rent ?? "₦300000/Year",
                          softWrap: true,
                          maxLines: 3,
                          style: const TextStyle(
                            color: Color(0xFF303030),
                            fontSize: 14,
                            fontFamily: 'Gelasio',
                            fontWeight: FontWeight.bold,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            remove == true ? removeProd! : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
