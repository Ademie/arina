import 'package:arina/constants/constants.dart';
import 'package:arina/providers/saved_provider.dart';
import 'package:arina/routes/bottom_nav.dart';
import 'package:arina/screens/products/product_details.dart';
import 'package:arina/shared/app_scaffold.dart';
import 'package:arina/shared/summary_card.dart';
import 'package:arina/widgets/arina_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({
    super.key,
  });

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
            if (savedHome.homes.isEmpty) {
              return SliverToBoxAdapter(
                child: SizedBox(
                  height: 800,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Center(
                          child: Text(
                            "Your saved Homes will appear here!",
                            style: nsmallText,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Center(
                            child: ArinaButton(
                          text: 'Browse Homes',
                          onPressed: () {
                            context.go("/home");
                          },
                          width: 220,
                          height: 60,
                        )),
                      ]),
                ),
              );
            }
            return SliverList.builder(
                itemCount: savedHome.homes.length,
                itemBuilder: (context, index) {
                  return SummaryCard(
                    title: savedHome.homes[index]["title"] ?? "",
                    propAddress:
                        savedHome.homes[index]["addrDescription"] ?? "",
                    imageURL:
                        savedHome.homes[index]["imagesURL"]?[0].toString() ??
                            "",
                    rent: '\$${savedHome.homes[index]["rent"] ?? ""}/year',
                    remove: true,
                    removeProd: Positioned(
                        top: 0,
                        right: 0,
                        child: SizedBox(
                            child: IconButton(
                                icon: const Icon(
                                  Ionicons.bookmark,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  savedHome.add(savedHome.homes[index]);
                                }))),
                    goTo: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetails(
                              propertyID: savedHome.homes[index]["propertyID"],
                              author: savedHome.homes[index]["author"]),
                        ),
                      );
                    },
                  );
                });
          })
        ],
      ),
      bottomNavigationBar: const BottomNav(index: 2),
    );
  }
}
