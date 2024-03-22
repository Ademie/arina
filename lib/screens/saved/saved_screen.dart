import 'package:arina/models/product_model.dart';
import 'package:arina/providers/saved_provider.dart';
import 'package:arina/routes/bottom_nav.dart';
import 'package:arina/screens/inspection/inspect_screen.dart';
import 'package:arina/shared/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key, required this.products});
  final List<ProductModel> products;

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Saved",
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
      bottomNavigationBar: const BottomNav(index: 2),
    );
  }
}
