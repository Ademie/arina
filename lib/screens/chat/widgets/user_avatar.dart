import 'package:arina/shared/cached_image.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.picture,
    this.width,
    this.height,
  });

  final String picture;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 40,
      height: height ?? 40,
      child: picture != ""
          ? CachedImage(
              imageUrl: picture,
              borderRadius: BorderRadius.circular(100),
            )
          : const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/person/man2.jpg')),
    );
  }
}
