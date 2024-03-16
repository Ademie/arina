import 'package:arina/models/product_model.dart';
import 'package:arina/providers/saved_provider.dart';
import 'package:arina/screens/inspection/inspection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          'Saved',
          style: TextStyle(
            color: Color(0xFF232323),
            fontSize: 18,
            fontFamily: 'Gelasio',
            fontWeight: FontWeight.w700,
            height: 0.08,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          Consumer<SavedProvider>(builder: (context, savedHouse, _) {
            return SliverList.builder(
                itemCount: savedHouse.houses.length,
                itemBuilder: (context, index) {
                  return SummaryCard(
                    title: savedHouse.houses[index].name,
                    imageURL: savedHouse.houses[index].imageUrl.toString(),
                    pricing:
                        '₦${savedHouse.houses[index].price.toStringAsFixed(2)}/year',
                  );
                });
          })
        ],
      ),
    );
  }
}
