import 'package:arina/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart' as fstorage;

class UploadForm extends StatefulWidget {
  UploadForm({super.key, this.imageFileUint8List});
  Uint8List? imageFileUint8List;

  @override
  State<UploadForm> createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  bool isUploading = false;
  String fireImageDownloadUrl = "";
  TextEditingController sellerNameController = TextEditingController();
  TextEditingController sellerPhoneController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    validateUploadForm() async {
      if (widget.imageFileUint8List != null) {
        if (sellerNameController.text.isNotEmpty &&
            sellerPhoneController.text.isNotEmpty &&
            productNameController.text.isNotEmpty &&
            productDescriptionController.text.isNotEmpty &&
            productPriceController.text.isNotEmpty) {
          setState(() {
            isUploading = true;
          });

          // upload image firestore
          String imageID = DateTime.now().microsecondsSinceEpoch.toString();
          fstorage.Reference firebaseStorageRef = fstorage
              .FirebaseStorage.instance
              .ref()
              .child('products images')
              .child(imageID);

          // used .putData instead of .putFile becasue our image is in bytes.
          fstorage.UploadTask uploadTaskImage =
              firebaseStorageRef.putData(widget.imageFileUint8List!);

          // get the download url after successful upload
          fstorage.TaskSnapshot taskSnapshot =
              await uploadTaskImage.whenComplete(() {});

          await taskSnapshot.ref.getDownloadURL().then((imageDownloadUrl) {
            fireImageDownloadUrl = imageDownloadUrl;
          });
          saveToCloudStorage();
        } else {
          Fluttertoast.showToast(msg: "Please complete all fields");
        }
      } else {
        Fluttertoast.showToast(msg: "Please select a valid image");
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Upload new product'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              // VALIDATE
              if (isUploading != true) {
                validateUploadForm();
              }
            },
            icon: Icon(Icons.cloud_upload),
          ),
        ],
      ),
      body: ListView(
        children: [
          isUploading == true
              ? const LinearProgressIndicator(
                  color: Colors.blue,
                )
              : Container(),
          // DISPLAY IMAGE
          SizedBox(
            height: 230,
            width: 700,
            child: Center(
              child: widget.imageFileUint8List != null
                  ? Image.memory(
                      widget.imageFileUint8List!,
                    )
                  : const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                    ),
            ),
          ),
          // SEPARATOR
          const Divider(
            color: Colors.white70,
            thickness: 1,
          ),
          // SELLER NAME
          ListTile(
            leading: Icon(
              Icons.person_pin_rounded,
              color: Colors.white,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: sellerNameController,
                style: TextStyle(color: Colors.grey),
                decoration: InputDecoration(
                    hintText: 'Seller Name',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            color: Colors.white70,
            thickness: 1,
          ),

          // SELLER PHONE
          ListTile(
            leading: Icon(
              Icons.phone,
              color: Colors.white,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: sellerPhoneController,
                style: TextStyle(color: Colors.grey),
                decoration: InputDecoration(
                    hintText: 'Seller Phone',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            color: Colors.white70,
            thickness: 1,
          ),

          // product NAME
          ListTile(
            leading: Icon(
              Icons.production_quantity_limits_rounded,
              color: Colors.white,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: productNameController,
                style: TextStyle(color: Colors.grey),
                decoration: InputDecoration(
                    hintText: 'product Name',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            color: Colors.white70,
            thickness: 1,
          ),

          // product DESCRIPTION
          ListTile(
            leading: Icon(
              Icons.description_outlined,
              color: Colors.white,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: productDescriptionController,
                style: TextStyle(color: Colors.grey),
                decoration: InputDecoration(
                    hintText: 'product Description',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            color: Colors.white70,
            thickness: 1,
          ),

          // product PRICE
          ListTile(
            leading: Icon(
              Icons.price_change_rounded,
              color: Colors.white,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: productPriceController,
                style: TextStyle(color: Colors.grey),
                decoration: InputDecoration(
                    hintText: 'product Price',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            color: Colors.white70,
            thickness: 1,
          ),
        ],
      ),
    );
  }

  saveToCloudStorage() {
    String productID = DateTime.now().microsecondsSinceEpoch.toString();
    // save everything to cloud firestore
    FirebaseFirestore.instance.collection("products").doc(productID).set({
      "productID": productID,
      "productName": productNameController.text,
      "productDescription": productDescriptionController.text,
      "productImage": fireImageDownloadUrl,
      "productPrice": productPriceController.text,
      "sellerName": sellerNameController.text,
      "sellerPhone": sellerPhoneController.text,
      "publishedDate": DateTime.now(),
      "status": "available",
    });

    Fluttertoast.showToast(msg: "product added successfully");
    setState(() {
      isUploading = false;
      widget.imageFileUint8List = null;
    });

    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (c) => Home()));
  }
}
