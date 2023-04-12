import 'package:arina/products.dart';
import 'package:flutter/material.dart';

class ProductUI extends StatefulWidget {
  ProductUI({super.key, this.productsModel, this.context});

  Products? productsModel;
  BuildContext? context;
  @override
  State<ProductUI> createState() => _ProductUIState();
}

class _ProductUIState extends State<ProductUI> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // send user to product details screen
      },
      splashColor: Colors.deepPurple,
      child: Padding(
        padding: EdgeInsets.all(6),
        child: SizedBox(
          height: 190,
          width: 400,
          child: Row(
            children: [
              // product IMAGE
              Image.network(
                widget.productsModel!.productImage.toString(),
                width: 140,
                height: 140,
              ),
              SizedBox(
                width: 4.0,
              ),
              // REMAINING INFO
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  // product NAME
                  Expanded(
                    child: Text(
                      widget.productsModel!.productName.toString(),
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  // SELLER NAME
                  Expanded(
                    child: Text(
                      widget.productsModel!.sellerName.toString(),
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
