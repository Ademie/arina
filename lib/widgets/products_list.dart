import 'package:arina/models/product_model.dart';
import 'package:arina/screens/products/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductGridView extends StatelessWidget {
  final List<ProductModel> products;

  const ProductGridView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 20.0,
          childAspectRatio: 0.7),
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  products[index].imageUrl.toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 60,
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: ShapeDecoration(
                    color: const Color(0x665F5F5F),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  child: SvgPicture.asset('assets/svg/shopping_bag.svg'),
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      products[index].name,
                      style: const TextStyle(
                        color: Color(0xFF5F5F5F),
                        fontSize: 14,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    Text(
                      '\$${products[index].price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Color(0xFF303030),
                        fontSize: 14,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ],
                )),
          ],
        );
      },
    );
  }
}
