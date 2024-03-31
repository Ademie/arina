import 'package:arina/models/product_model.dart';
import 'package:arina/providers/saved_provider.dart';
import 'package:arina/routes/bottom_nav.dart';
import 'package:arina/shared/app_scaffold.dart';
import 'package:arina/shared/summary_card.dart';
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
          Consumer<SavedProvider>(builder: (context, savedHome, _) {
            return SliverList.builder(
                itemCount: savedHome.homes.length,
                itemBuilder: (context, index) {
                  return SummaryCard(
                    title: savedHome.homes[index]["title"],
                    propAddress: savedHome.homes[index]["propAddress"],
                    imageURL:
                        savedHome.homes[index]["imagesURL"]?[0].toString(),
                    rent: '\$${savedHome.homes[index]["rent"]}/year',
                  );
                });
          })
        ],
      ),
      bottomNavigationBar: const BottomNav(index: 2),
    );
  }
}
