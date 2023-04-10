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
            // FORM
          // SELLER INFO
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
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return uploadFormScreen();
  }
}
