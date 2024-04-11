import 'package:homeradar/providers/saved_provider.dart';
import 'package:homeradar/screens/products/product_details.dart';
import 'package:homeradar/shared/cached_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final getProducts = firestore.collection("properties").snapshots();
    List<String> propertyIDs = [];
    List<String> authorIDs = [];

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>?>(
        stream: getProducts,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            ));
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 25,
              mainAxisSpacing: 20.0,
              childAspectRatio: 0.7,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              List mylist =
                  snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) {
                Map<String, dynamic> data =
                    documentSnapshot.data()! as Map<String, dynamic>;

                propertyIDs.add(documentSnapshot.id.toString());
                authorIDs.add(documentSnapshot.get("author"));
                return data;
              }).toList();
              return Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetails(
                                  propertyID: propertyIDs[index],
                                  author: authorIDs[index],
                                )),
                      );
                    },
                    child: CachedImage(
                      imageUrl: mylist[index]["imagesURL"][0],
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: ShapeDecoration(
                          color: const Color.fromARGB(255, 247, 244, 244),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        child: Consumer<SavedProvider>(
                            builder: (context, saveHome, _) {
                          bool isSavedProduct = saveHome.isSaved(mylist[index]);

                          return IconButton(
                              onPressed: () {
                                saveHome.add(mylist[index]);
                              },
                              icon: isSavedProduct
                                  ? const Icon(Ionicons.bookmark,
                                      color: Colors.black)
                                  : const Icon(
                                      Ionicons.bookmark_outline,
                                      color: Colors.black,
                                    ));
                        })),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 70,
                        padding: const EdgeInsets.only(left: 5),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(130, 9, 9, 9),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              mylist[index]["title"],
                              style: const TextStyle(
                                color: Color.fromARGB(255, 253, 253, 253),
                                fontSize: 16,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            Text(
                              '\$${mylist[index]["rent"]}',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 250, 250, 250),
                                fontSize: 14,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              );
            },
          );
        });
  }
}
