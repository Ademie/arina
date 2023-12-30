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
