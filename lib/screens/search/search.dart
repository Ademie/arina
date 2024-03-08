import 'package:arina/models/product_model.dart';
import 'package:arina/screens/inspection/inspection.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class Search extends StatelessWidget {
  const Search({super.key, required this.products});
  final List<ProductModel> products;

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
                child: const Row(
                  children: [
                    Icon(
                      Ionicons.search_outline,
                      color: Color.fromARGB(177, 63, 63, 63),
                    ),
                    Flexible(
                      child: TextField(
                        style: TextStyle(
                            fontFamily: "Nunito Sans", color: Colors.black),
                        cursorColor: Colors.black,
                        decoration: InputDecoration.collapsed(
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
              itemCount: products.length,
              itemBuilder: (context, index) {
                return SummaryCard(
                  title: products[index].name,
                  imageURL: products[index].imageUrl.toString(),
                  pricing: '₦${products[index].price.toStringAsFixed(2)}/year',
                );
              })
        ],
      ),
    );
  }
}
