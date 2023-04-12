import 'dart:typed_data';

import 'package:arina/api_consumer.dart';
import 'package:arina/screens/upload_form.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadProducts extends StatefulWidget {
  const UploadProducts({super.key});

  @override
  State<UploadProducts> createState() => _UploadProductsState();
}

class _UploadProductsState extends State<UploadProducts> {
  // define image file in bits form
  Uint8List? imageFileUint8List;

  Widget defaultScreen() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Upload New product'),
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
              child: Text('Add New product'),
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
              'product Image',
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

  captureWithCamera() async {
    Navigator.pop(context);
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        String imagePath = pickedImage.path;
        //  convert image to bytes
        imageFileUint8List = await pickedImage.readAsBytes();

        // remove image background

        imageFileUint8List = await ApiConsumer().removeBgApi(imagePath);
        setState(() {
          imageFileUint8List;
        });
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        imageFileUint8List = null;
      });
    }
  }

  uploadFromGallery() async {
    Navigator.pop(context);
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        String imagePath = pickedImage.path;
        //  convert image to bytes
        imageFileUint8List = await pickedImage.readAsBytes();

        // remove image background
        imageFileUint8List = await ApiConsumer().removeBgApi(imagePath);

        setState(() {
          imageFileUint8List;
        });
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        imageFileUint8List = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return imageFileUint8List == null
        ? defaultScreen()
        : UploadForm(
            imageFileUint8List: imageFileUint8List,
          );
  }
}
