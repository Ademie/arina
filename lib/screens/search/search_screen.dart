import 'package:arina/data/data.dart';
import 'package:arina/models/product_model.dart';
import 'package:arina/shared/summary_card.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.products});
  final List<ProductModel> products;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = "";

  List<ProductModel> searchResults = [];

  void onQueryChanged(String query) {
    setState(() {
      if (query.isNotEmpty) {
        searchResults = productData
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
        searchResults.sort((a, b) => a.name
            .toLowerCase()
            .indexOf(query.toLowerCase())
            .compareTo(b.name.toLowerCase().indexOf(query.toLowerCase())));
        // https://chat.openai.com/c/01848815-c99b-44b8-a334-393ee98df2e0#:~:text=Sure%2C%20let%27s%20break%20down%20the%20code%3A
      } else {
        searchResults = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SEARCH BAR
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
                      child: TextField(
                        onChanged: onQueryChanged,
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
                icon: const Icon(Icons.cancel_outlined))
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return SummaryCard(
                  title: searchResults[index].name,
                  imageURL: searchResults[index].imageUrl.toString(),
                  rent:
                      '₦${searchResults[index].price.toStringAsFixed(2)}/year',
                );
              })
        ],
      ),
    );
  }
}
