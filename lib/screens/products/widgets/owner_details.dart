import 'package:arina/providers/owner_provider.dart';
import 'package:arina/shared/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OwnerDetails extends StatelessWidget {
  const OwnerDetails({
    super.key,
    required this.ownerProvider,
  });

  final OwnerProvider ownerProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: 50,
              height: 50,
              child: ownerProvider.picture != ""
                  ? CachedImage(
                      imageUrl: ownerProvider.picture,
                      borderRadius: BorderRadius.circular(100),
                    )
                  : const CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage('assets/images/person/man2.jpg'))),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${ownerProvider.firstName} ${ownerProvider.lastName}",
                style: const TextStyle(
                  color: Color(0xFF232323),
                  fontSize: 18,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              const Text(
                'Owner',
                style: TextStyle(
                  color: Color.fromARGB(255, 76, 76, 76),
                  fontFamily: 'Nunito Sans',
                  height: 0,
                  letterSpacing: 0.90,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: SvgPicture.asset('assets/svg/verified.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
