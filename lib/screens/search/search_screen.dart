import 'package:arina/screens/products/product_details.dart';
import 'package:arina/shared/summary_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   List products = [];
//   // String query = "";

//   List searchResults = [];
//   final ref = FirebaseFirestore.instance.collection("properties");

//   Future<void> loadSavedProducts() async {
//     final snapshot = await ref.get();
//     final productsData = snapshot.docs;

//     products = productsData;
//   }

//   void onQueryChanged(String query) {
//     setState(() {
//       if (query.isNotEmpty) {
//         searchResults = products
//             .where((element) =>
//                 element["title"].toLowerCase().contains(query.toLowerCase()) ||
//                 element["type"].toLowerCase().contains(query.toLowerCase()))
//             .toList();
//         searchResults.sort((a, b) => a["title"]
//             .toLowerCase()
//             .indexOf(query.toLowerCase())
//             .compareTo(b["title"].toLowerCase().indexOf(query.toLowerCase())));
//       } else {
//         searchResults = [];
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     loadSavedProducts();
//     return Scaffold(
//       // SEARCH BAR
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         scrolledUnderElevation: 0,
//         title: Row(
//           children: [
//             Flexible(
//               child: Container(
//                 height: 40,
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.grey,
//                       blurRadius: 2.0,
//                       spreadRadius: 0.005,
//                       offset: Offset(
//                         0.5,
//                         0.5,
//                       ),
//                     )
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     const Icon(
//                       Ionicons.search_outline,
//                       color: Color.fromARGB(177, 63, 63, 63),
//                     ),
//                     Flexible(
//                       child: TextFormField(
//                         // onChanged: onQueryChanged,

//                         style: const TextStyle(
//                             fontFamily: "Nunito Sans", color: Colors.black),
//                         cursorColor: Colors.black,
//                         decoration: const InputDecoration.collapsed(
//                           hintText: 'City, Neighborhood',
//                           hintStyle:
//                               TextStyle(color: Color.fromARGB(177, 51, 51, 51)),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: const Icon(Icons.cancel_outlined))
//           ],
//         ),
//       ),
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverList.builder(
//               itemCount: searchResults.length,
//               itemBuilder: (context, index) {
//                 return SummaryCard(
//                   title: searchResults[index]["title"],
//                   imageURL: searchResults[index]["imagesURL"][0].toString(),
//                   rent: '₦${searchResults[index]["rent"]}/year',
//                   goTo: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => ProductDetails(
//                               propertyID: searchResults[index]["propertyID"],
//                               author: searchResults[index]["author"])),
//                     );
//                   },
//                 );
//               })
//         ],
//       ),
//     );
//   }
// }

class SearchScreen extends StatefulWidget {
  final String? query;

  const SearchScreen({Key? key, this.query}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List products = [];
  List searchResults = [];
  final ref = FirebaseFirestore.instance.collection("properties");

  @override
  void initState() {
    super.initState();
    loadSavedProducts();
  }

  Future<void> loadSavedProducts() async {
    final snapshot = await ref.get();
    final productsData = snapshot.docs;

    setState(() {
      products = productsData;
      onQueryChanged(
          widget.query!); // Call onQueryChanged with the initial query
    });
  }

  void onQueryChanged(String query) {
    setState(() {
      if (query.isNotEmpty) {
        searchResults = products
            .where((element) =>
                element["title"].toLowerCase().contains(query.toLowerCase()) ||
                element["type"].toLowerCase().contains(query.toLowerCase()))
            .toList();
        searchResults.sort((a, b) => a["title"]
            .toLowerCase()
            .indexOf(query.toLowerCase())
            .compareTo(b["title"].toLowerCase().indexOf(query.toLowerCase())));
      } else {
        searchResults = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Flexible(
              child: Container(
                height: 40,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      spreadRadius: 0.005,
                      offset: Offset(
                        0.5,
                        0.5,
                      ),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Ionicons.search_outline,
                      color: Color.fromARGB(177, 63, 63, 63),
                    ),
                    Flexible(
                      child: TextFormField(
                        initialValue: widget.query, // Set initial value
                        onChanged:
                            onQueryChanged, // Call onQueryChanged on change
                        style: const TextStyle(
                            fontFamily: "Nunito Sans", color: Colors.black),
                        cursorColor: Colors.black,
                        decoration: const InputDecoration.collapsed(
                          hintText: 'City, Neighborhood',
                          hintStyle:
                              TextStyle(color: Color.fromARGB(177, 51, 51, 51)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.cancel_outlined),
            )
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return SummaryCard(
                  title: searchResults[index]["title"],
                  imageURL: searchResults[index]["imagesURL"][0].toString(),
                  rent: '₦${searchResults[index]["rent"]}/year',
                  goTo: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(
                          propertyID: searchResults[index]["propertyID"],
                          author: searchResults[index]["author"],
                        ),
                      ),
                    );
                  },
                );
              },
              childCount: searchResults.length,
            ),
          ),
        ],
      ),
    );
  }
}
