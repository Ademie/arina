import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Amenities extends StatelessWidget {
  const Amenities({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 150, right: 30, left: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: ListTile(
                  minLeadingWidth: 5,
                  leading: SvgPicture.asset(
                    'assets/svg/rectangle.svg',
                    height: 20,
                  ),
                  title: const Text('Ceiling'),
                ),
              ),
              const Text("POP")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: ListTile(
                  minLeadingWidth: 5,
                  leading: SvgPicture.asset(
                    'assets/svg/tiled.svg',
                    height: 20,
                  ),
                  title: const Text('Flooring'),
                ),
              ),
              const Text("Tiled")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: ListTile(
                  minLeadingWidth: 5,
                  leading: SvgPicture.asset(
                    'assets/svg/road.svg',
                    height: 20,
                  ),
                  title: const Text('Road Network'),
                ),
              ),
              const Flexible(
                child: Text("Good"),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: ListTile(
                  minLeadingWidth: 5,
                  leading: SvgPicture.asset(
                    'assets/svg/swimming.svg',
                    height: 20,
                  ),
                  title: const Text('Pool'),
                ),
              ),
              const Text("True")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: ListTile(
                  minLeadingWidth: 5,
                  leading: SvgPicture.asset(
                    'assets/svg/fence.svg',
                    height: 20,
                  ),
                  title: const Text('Fencing'),
                ),
              ),
              const Flexible(child: Text("True"))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: ListTile(
                  minLeadingWidth: 5,
                  leading: SvgPicture.asset(
                    'assets/svg/security.svg',
                    height: 20,
                  ),
                  title: const Text('Security'),
                ),
              ),
              const Text("True")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: ListTile(
                  minLeadingWidth: 5,
                  leading: SvgPicture.asset(
                    'assets/svg/fire.svg',
                    height: 20,
                  ),
                  title: const Text('Fire Alarm'),
                ),
              ),
              const Text("True")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: ListTile(
                  minLeadingWidth: 5,
                  leading: SvgPicture.asset(
                    'assets/svg/sofa.svg',
                    height: 20,
                  ),
                  title: const Text('Furnished'),
                ),
              ),
              const Text("True")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: ListTile(
                  minLeadingWidth: 5,
                  leading: SvgPicture.asset(
                    'assets/svg/ac.svg',
                    height: 20,
                  ),
                  title: const Text('Air Conditioning'),
                ),
              ),
              const Text("True")
            ],
          ),
        ],
      ),
    );
  }
}
