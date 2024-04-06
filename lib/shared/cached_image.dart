import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:ionicons/ionicons.dart';

class CachedImage extends StatefulWidget {
  const CachedImage({
    super.key,
    required this.imageUrl,
    this.borderRadius,
  });

  final String imageUrl;
  final BorderRadius? borderRadius;

  @override
  State<CachedImage> createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  static final customCacheManager = CacheManager(
    Config("customKey",
        stalePeriod: const Duration(days: 5), maxNrOfCacheObjects: 400),
  );
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: UniqueKey(),
      cacheManager: customCacheManager,
      imageUrl: widget.imageUrl,
      placeholder: (context, url) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: const Icon(Ionicons.image),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
