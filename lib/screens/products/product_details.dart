import 'package:homeradar/providers/owner_provider.dart';
import 'package:homeradar/screens/products/widgets/amenities.dart';
import 'package:homeradar/screens/products/widgets/owner_details.dart';
import 'package:homeradar/screens/products/widgets/price_summary.dart';
import 'package:homeradar/screens/products/widgets/product_details_bottom.dart';
import 'package:homeradar/shared/gmap_preview.dart';
import 'package:homeradar/screens/products/widgets/product_showcase.dart';
import 'package:homeradar/shared/map_preview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  void dispose() {
    ownerProvider.dispose();
    super.dispose();
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
          final String title = data?["title"] ?? "";
          final String address = data?["addrDescription"] ?? "";
          final String description = data?["description"] ?? "";
          final String imageURL = data?["imagesURL"][0] ?? "";
          final String duration = data?["duration"] ?? "";
          final String rent = data?["rent"] ?? "";
          final String security = data?["security"] ?? "";
          final String service = data?["service"] ?? "";
          final String total = data?["total"] ?? "";
          final double latitude = data?["latitude"] ?? 0.0;
          final double longitude = data?["longitude"] ?? 0.0;

          var otherImages = data?["imagesURL"];
          return Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 350,
                  flexibleSpace: FlexibleSpaceBar(
                    background: ProductShowcase(
                      mainImageURL: imageURL,
                      otherImages: otherImages,
                      address: address,
                    ),
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
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Color(0xFF5F5F5F),
                          fontSize: 14,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                        trimLines: 5,
                        colorClickableText: Colors.pink,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: ' Show less',
                        moreStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // OWNER DETAILS
                    OwnerDetails(ownerProvider: ownerProvider),
                    // LOCATION
                    SizedBox(
                      height: 300,
                      child: Stack(
                        children: [
                          // GMapPreview(latitude: latitude, longitude: longitude),
                          MapPreview(latitude: latitude, longitude: longitude),
                          Positioned(
                              top: 0,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (_) => MapDialog(
                                      latitude: latitude,
                                      longitude: longitude,
                                    ),
                                    // GMapDialog(
                                    //   latitude: latitude,
                                    //   longitude: longitude,
                                    // ),
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
            bottomSheet: ProductDetailsBottom(data: data, widget: widget),
          );
        });
  }
}
