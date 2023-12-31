import 'package:arina/screens/arview/arview.dart';
import 'package:arina/screens/products/product_details.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: ProductDetails(),
      home: ArView(),
    );
  }
}
