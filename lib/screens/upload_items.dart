import 'dart:typed_data';

import 'package:arina/screens/upload_form.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadItems extends StatefulWidget {
  const UploadItems({super.key});

  @override
  State<UploadItems> createState() => _UploadItemsState();
}

class _UploadItemsState extends State<UploadItems> {
  // define image file in bits form
  Uint8List? imageFileUint8List;

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

  captureWithCamera() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        String imagePath = pickedImage.path;
        //  convert image to bytes
        imageFileUint8List = await pickedImage.readAsBytes();

        // remove image background
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
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        String imagePath = pickedImage.path;
        //  convert image to bytes
        imageFileUint8List = await pickedImage.readAsBytes();

        // remove image background
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
