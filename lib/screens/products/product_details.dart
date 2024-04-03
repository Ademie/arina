import 'package:arina/providers/owner_provider.dart';
import 'package:arina/providers/saved_provider.dart';
import 'package:arina/screens/inspection/inspect_screen.dart';
import 'package:arina/screens/products/widgets/amenities.dart';
import 'package:arina/screens/products/widgets/price_summary.dart';
import 'package:arina/shared/map_preview.dart';
import 'package:arina/widgets/arina_button.dart';
import 'package:arina/screens/products/widgets/product_showcase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:readmore/readmore.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails(
      {super.key, required this.propertyID, required this.author});

  final String propertyID;
  final String author;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late OwnerProvider ownerProvider;
  @override
  void initState() {
    ownerProvider = OwnerProvider();
    ownerProvider.fetchOwner(widget.author);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final properties =
        firestore.collection("properties").doc(widget.propertyID).get();

    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: properties,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              )),
            );
          }

          final data = snapshot.data!.data();
          final String title = data?["title"];
          final String address = data?["propAddress"];
          final String description = data?["description"];
          final String imageURL = data?["imagesURL"][0];
          final String duration = data?["duration"];
          final String rent = data?["rent"];
          final String security = data?["security"];
          final String service = data?["service"];
          final String total = data?["total"];

          List<dynamic> otherImages = data?["imagesURL"] as List<dynamic>;

          return Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 350,
                  flexibleSpace: FlexibleSpaceBar(
                    background: ProductShowcase(
                        mainImageURL: imageURL, otherImages: otherImages),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Color(0xFF303030),
                              fontSize: 26,
                              fontFamily: 'Gelasio',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                          Text(
                            address,
                            // '14, James Kowope Street, Akure Ondo, Nigeria',
                            style: const TextStyle(
                              color: Color.fromARGB(197, 48, 48, 48),
                              fontSize: 14,
                              fontFamily: 'Gelasio',
                              height: 0,
                            ),
                          ),
                        ],
                      )),
                ),
                SliverList.list(
                  children: [
                    // PRODUCT DESCRIPTION
                    Container(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, bottom: 25),
                      child: ReadMoreText(
                        description,
// "Cozy and modern 6-bedroom apartment available for rent in prime location. Fully furnished with stylish decor and amenities including a spacious living area, fully equipped kitchen, and balcony with city views. Perfect for professionals or couples seeking comfort and convenience. Don't miss out on this opportunity to call it home!",
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
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
                        moreStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
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
                                  child:
                                      SvgPicture.asset('assets/svg/call.svg'),
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
                                  child: SvgPicture.asset(
                                      'assets/svg/message.svg'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // LOCATION
                    SizedBox(
                      height: 300,
                      child: Stack(
                        children: [
                          // MapPreview(),
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
                    // PRICE SUMMARY
                    PriceSummary(
                        duration: duration,
                        rent: rent,
                        security: security,
                        service: service,
                        total: total),
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
                    const Amenities()
                  ],
                ),
              ],
            ),
            bottomSheet:
                Consumer<SavedProvider>(builder: (context, saveHome, _) {
              bool isSavedProduct = saveHome.isSaved(data!);
              return Container(
                height: 150,
                color: Colors.white,
                padding: const EdgeInsets.all(25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        saveHome.add(data);
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        padding: const EdgeInsets.all(18),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF0F0F0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: isSavedProduct
                            ? SvgPicture.asset("assets/svg/marker-filled.svg")
                            : SvgPicture.asset("assets/svg/marker.svg"),
                      ),
                    ),
                    ArinaButton(
                      text: 'Book Inspection',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const InspectScreen()));
                      },
                      width: 220,
                      height: 60,
                    )
                  ],
                ),
              );
            }),
          );
        });
  }
}
