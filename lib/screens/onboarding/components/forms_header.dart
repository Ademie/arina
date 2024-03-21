import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FormsHeader extends StatelessWidget {
  const FormsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 21.87,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 105,
            height: 1,
            decoration: ShapeDecoration(
              color: const Color(0xFFBDBDBD),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2)),
            ),
          ),
          SvgPicture.asset("assets/svg/Group.svg"),
          Container(
            width: 105,
            height: 1,
            decoration: ShapeDecoration(
              color: const Color(0xFFBDBDBD),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2)),
            ),
          )
        ],
      ),
    );
  }
}
