import 'package:flutter/material.dart';

class ProductsList extends StatelessWidget {
  final List<String> items = List.generate(20, (index) => 'Item $index');

  ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return GridItem(item: items[index]);
            },
            childCount: items.length,
          ),
        ),
      ],
    );
  }
}

class GridItem extends StatelessWidget {
  final String item;

  const GridItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 350,
      decoration:  const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
          image: AssetImage('assets/images/products/desk.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
