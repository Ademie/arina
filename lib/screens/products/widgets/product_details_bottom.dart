import 'package:arina/providers/auth_provider.dart';
import 'package:arina/providers/saved_provider.dart';
import 'package:arina/screens/chat/chat_list_screen.dart';
import 'package:arina/screens/inspection/inspect_screen.dart';
import 'package:arina/screens/products/product_details.dart';
import 'package:arina/widgets/arina_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class ProductDetailsBottom extends StatelessWidget {
  const ProductDetailsBottom({
    super.key,
    required this.data,
    required this.widget,
  });

  final Map<String, dynamic>? data;
  final ProductDetails widget;

  @override
  Widget build(BuildContext context) {
    return Consumer<FireAuthProvider>(builder: (context, fireAuthProvider, _) {
      return Consumer<SavedProvider>(builder: (context, saveHome, _) {
        bool isSavedProduct = data != null && saveHome.isSaved(data!);

        return Container(
          height: 150,
          color: Colors.white,
          padding: const EdgeInsets.all(25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.author == fireAuthProvider.currentUser!.uid
                  ? GestureDetector(
                      onTap: () {
                        // saveHome.add(data!);
                      },
                      child: Container(
                          width: 60,
                          height: 60,
                          padding: const EdgeInsets.all(18),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF0F0F0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Icon(Ionicons.trash)),
                    )
                  : GestureDetector(
                      onTap: () {
                        saveHome.add(data!);
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        padding: const EdgeInsets.all(18),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF0F0F0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: isSavedProduct
                            ? SvgPicture.asset("assets/svg/marker-filled.svg")
                            : SvgPicture.asset("assets/svg/marker.svg"),
                      ),
                    ),
              widget.author == fireAuthProvider.currentUser!.uid
                  ? ArinaButton(
                      text: 'Check Messages',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MessageListScreen(
                                      propertyID: widget.propertyID,
                                      author: widget.author,
                                    )
                                //  InspectScreen(
                                //   propertyID: widget.propertyID,
                                //   author: widget.author,
                                // ),
                                ));
                      },
                      width: 220,
                      height: 60,
                    )
                  : ArinaButton(
                      text: 'Book Inspection',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InspectScreen(
                                      propertyID: widget.propertyID,
                                      author: widget.author,
                                    )));
                      },
                      width: 220,
                      height: 60,
                    )
            ],
          ),
        );
      });
    });
  }
}
