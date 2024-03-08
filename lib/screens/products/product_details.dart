import 'package:arina/screens/inspection/inspection.dart';
import 'package:arina/widgets/arina_button.dart';
import 'package:arina/widgets/product_showcase.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 350,
            flexibleSpace: FlexibleSpaceBar(
              background: ProductShowcase(),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'James Villa',
                    style: TextStyle(
                      color: Color(0xFF303030),
                      fontSize: 26,
                      fontFamily: 'Gelasio',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  Text(
                    '14, James Kowope Street, Akure Ondo, Nigeria',
                    style: TextStyle(
                      color: Color.fromARGB(197, 48, 48, 48),
                      fontSize: 14,
                      fontFamily: 'Gelasio',
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList.list(
            children: [
              // PRODUCT DESCRIPTION
              Container(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                child: const ReadMoreText(
                  "Cozy and modern 6-bedroom apartment available for rent in prime location. Fully furnished with stylish decor and amenities including a spacious living area, fully equipped kitchen, and balcony with city views. Perfect for professionals or couples seeking comfort and convenience. Don't miss out on this opportunity to call it home!",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Color(0xFF5F5F5F),
                    fontSize: 14,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w300,
                    height: 0,
                  ),
                  trimLines: 2,
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: ' Show less',
                  moreStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              // OWNER DETAILS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircleAvatar(
                      radius: 30.0,
                      backgroundImage:
                          AssetImage('assets/images/person/man2.jpg'),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'James Rodriguez',
                          style: TextStyle(
                            color: Color(0xFF232323),
                            fontSize: 18,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        Text(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: SvgPicture.asset('assets/svg/call.svg'),
                          ),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: SvgPicture.asset('assets/svg/message.svg'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // LOCATION
              Stack(
                children: [
                  Container(
                    width: 600,
                    height: 400,
                    padding: const EdgeInsets.all(25),
                    // child: FlutterMap(
                    //   options: const MapOptions(
                    //     initialCenter:
                    //         LatLng(7.30295288579095, 5.13890892669223),
                    //     initialZoom: 12.0,
                    //   ),
                    //   children: [
                    //     TileLayer(
                    //       urlTemplate:
                    //           'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    //       userAgentPackageName: 'com.example.app',
                    //     ),
                    //     const MarkerLayer(markers: [
                    //       Marker(
                    //         point: LatLng(7.30295288579095, 5.13890892669223),
                    //         child: Icon(
                    //           Icons.location_on,
                    //           color: Colors.red,
                    //           size: 50.0,
                    //         ),
                    //       )
                    //     ])
                    //   ],
                    // ),
                  ),
                  Positioned(
                      top: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (_) => const MapDialog(),
                          );
                        },
                        child: Container(
                          color: const Color.fromARGB(0, 33, 149, 243),
                          width: 600,
                          height: 200,
                        ),
                      ))
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              const Divider(
                color: Color.fromARGB(19, 104, 104, 104),
              ),
              // PRICE
              const Padding(
                padding: EdgeInsets.all(25),
                child: Text(
                  'PRICING & LEASE',
                  style: TextStyle(
                    color: Color(0xFF303030),
                    fontSize: 24,
                    fontFamily: 'Gelasio',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
              // LEASE BREAKDOWN
              const Padding(
                padding: EdgeInsets.only(right: 25, left: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: ListTile(
                            title: Text('Duration'),
                          ),
                        ),
                        Text("12 months")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: ListTile(
                            title: Text('Rent'),
                          ),
                        ),
                        Text("₦300000")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: ListTile(
                            title: Text('Security'),
                          ),
                        ),
                        Text("₦20000")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: ListTile(
                            title: Text('Service Charge'),
                          ),
                        ),
                        Text("₦10000")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: ListTile(
                            title: Text('Total Package'),
                          ),
                        ),
                        Text("₦330000")
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Color.fromARGB(19, 104, 104, 104),
              ),
              const SizedBox(
                height: 40,
              ),
              // AMENITIES TITLE
              const Padding(
                padding: EdgeInsets.all(25),
                child: Text(
                  'AMENITIES',
                  style: TextStyle(
                    color: Color(0xFF303030),
                    fontSize: 24,
                    fontFamily: 'Gelasio',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
              // AMENITIES BODY
              Padding(
                padding: const EdgeInsets.only(bottom: 150, right: 30, left: 5),
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
              )
            ],
          ),
        ],
      ),
      bottomSheet: Container(
        height: 150,
        color: Colors.white,
        padding: const EdgeInsets.all(25),
        child: Row(
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
              text: 'Book Inspection',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Inspection()));
              },
              width: 220,
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}

class MapDialog extends StatelessWidget {
  const MapDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(7.30295288579095, 5.13890892669223),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          const MarkerLayer(markers: [
            Marker(
              point: LatLng(7.30295288579095, 5.13890892669223),
              child: Icon(
                Icons.location_on,
                color: Colors.red,
                size: 50.0,
              ),
            )
          ])
        ],
      ),
    );
  }
}
