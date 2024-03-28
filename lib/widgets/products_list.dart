import 'package:arina/models/product_model.dart';
import 'package:arina/providers/saved_provider.dart';
import 'package:arina/screens/products/product_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class ProductGridView extends StatelessWidget {
  final List<ProductModel> products;

  const ProductGridView({super.key, required this.products});

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
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                    mylist[index]["imagesURL"][0].toString()),
                                fit: BoxFit.cover)),
                      )),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: ShapeDecoration(
                          color: const Color(0x665F5F5F),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        child: Consumer<SavedProvider>(
                            builder: (context, saveHouse, _) {
                          return IconButton(
                              onPressed: () {
                                saveHouse.add(mylist[index]["propertyID"]);
                              },
                              icon: const Icon(
                                Ionicons.bookmark_outline,
                                color: Colors.white,
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
                          color: Color.fromARGB(121, 95, 95, 95),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              mylist[index]["title"].toString(),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 253, 253, 253),
                                fontSize: 16,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            Text(
                              '₦${mylist[index]["rent"]}',
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
