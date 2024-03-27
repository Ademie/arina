import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id;
  String name;
  double price;
  String? imageUrl;
  String? description;

  ProductModel({
    this.id = "",
    required this.name,
    required this.price,
    this.imageUrl,
    this.description,
  });

  factory ProductModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ProductModel(
      id: data?["id"],
      name: data?["name"],
      price: data?["price"],
      imageUrl: data?["imageUrl"],
      description: data?["description"],
    );
  }

  ProductModel.fromJson(this.id, Map<String, dynamic> json)
      : name = json["name"],
        price = json["price"].toDouble(),
        imageUrl = json["imageUrl"] ?? '',
        description = json["description"] ?? '';

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "imageUrl": imageUrl,
      };
}
