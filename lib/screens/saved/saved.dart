import 'package:arina/models/product_model.dart';
import 'package:arina/screens/inspection/inspection.dart';
import 'package:flutter/material.dart';

class Saved extends StatefulWidget {
  const Saved({super.key, required this.products});
  final List<ProductModel> products;

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Saved
      appBar: AppBar(scrolledUnderElevation: 0, title: const Text('Saved')),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList.builder(
              itemCount: widget.products.length,
              itemBuilder: (context, index) {
                return SummaryCard(
                  title: widget.products[index].name,
                  imageURL: widget.products[index].imageUrl.toString(),
                  pricing:
                      '₦${widget.products[index].price.toStringAsFixed(2)}/year',
                );
              })
        ],
      ),
    );
  }
}
