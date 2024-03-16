import 'package:arina/models/product_model.dart';
import 'package:arina/providers/saved_provider.dart';
import 'package:arina/screens/products/product_details.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class ProductGridView extends StatelessWidget {
  final List<ProductModel> products;

  const ProductGridView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 25,
        mainAxisSpacing: 20.0,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductDetails()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage(
                            products[index].imageUrl.toString(),
                          ),
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
                  child:
                      Consumer<SavedProvider>(builder: (context, saveHouse, _) {
                    return IconButton(
                        onPressed: () {
                          saveHouse.add(products[index]);
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
                        products[index].name,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 253, 253, 253),
                          fontSize: 16,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      Text(
                        '₦${products[index].price.toStringAsFixed(2)}',
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
  }
}
