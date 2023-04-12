import 'package:cloud_firestore/cloud_firestore.dart';

// DATA RETURNED FROM FIREBASE IS ALWAYS IS JSON FORMAT
class Products {
  String? productID;
  String? productName;
  String? productDescription;
  String? productImage;
  String? productPrice;
  String? sellerName;
  String? sellerPhone;
  Timestamp? publishedDate;
  String? status;

  Products(
      {this.productID,
      this.productName,
      this.productDescription,
      this.productImage,
      this.productPrice,
      this.sellerName,
      this.sellerPhone,
      this.publishedDate,
      this.status});
  Products.fromJson(Map<String, dynamic> json) {
    productID = json["productID"];
    productName = json["productName"];
    productDescription = json["productDescription"];
    productImage = json["productImage"];
    productPrice = json["productPrice"];
    sellerName = json["sellerName"];
    sellerPhone = json["sellerPhone"];
    publishedDate = json["publishedDate"];
    status = json["status"];
  }
}
