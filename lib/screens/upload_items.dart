import 'dart:typed_data';

import 'package:flutter/material.dart';

class UploadItems extends StatefulWidget {
  const UploadItems({super.key});

  @override
  State<UploadItems> createState() => _UploadItemsState();
}

class _UploadItemsState extends State<UploadItems> {
  // define image file in bits form
  Uint8List? imageFileUint8List;
  bool isUploading = false;
  TextEditingController sellerNameController = TextEditingController();
  TextEditingController sellerPhoneController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();

  // Upload form
  Widget uploadFormScreen() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Upload new item'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.cloud_upload))],
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
              child: imageFileUint8List != null
                  ? Image.memory(
                      imageFileUint8List!,
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

          // ITEM NAME
          ListTile(
            leading: Icon(
              Icons.production_quantity_limits_rounded,
              color: Colors.white,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: itemNameController,
                style: TextStyle(color: Colors.grey),
                decoration: InputDecoration(
                    hintText: 'Item Name',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            color: Colors.white70,
            thickness: 1,
          ),

          // ITEM DESCRIPTION
          ListTile(
            leading: Icon(
              Icons.description_outlined,
              color: Colors.white,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: itemDescriptionController,
                style: TextStyle(color: Colors.grey),
                decoration: InputDecoration(
                    hintText: 'Item Description',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            color: Colors.white70,
            thickness: 1,
          ),

          // ITEM PRICE
          ListTile(
            leading: Icon(
              Icons.price_change_rounded,
              color: Colors.white,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: itemPriceController,
                style: TextStyle(color: Colors.grey),
                decoration: InputDecoration(
                    hintText: 'Item Price',
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

  Widget defaultScreen() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Upload New Item'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_a_photo_outlined,
              color: Colors.white,
              size: 200,
            ),
            ElevatedButton(
              onPressed: () {
                showDialogBox();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black54),
              child: Text('Add New Item'),
            )
          ],
        ),
      ),
    );
  }

  showDialogBox() {
    return showDialog(
        context: context,
        builder: (c) {
          return SimpleDialog(
            backgroundColor: Colors.black,
            title: Text(
              'Item Image',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  captureWithCamera();
                },
                child: Text(
                  'Capture Image with Camera',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  uploadFromGallery();
                },
                child: Text(
                  'Upload from Gallery',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          );
        });
  }

  captureWithCamera() {}
  uploadFromGallery() {}
  @override
  Widget build(BuildContext context) {
    return defaultScreen();
  }
}
