import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UploadForm extends StatefulWidget {
  const UploadForm({super.key, this.imageFileUint8List});
  final Uint8List? imageFileUint8List;

  @override
  State<UploadForm> createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  bool isUploading = false;
  TextEditingController sellerNameController = TextEditingController();
  TextEditingController sellerPhoneController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  


  @override
  Widget build(BuildContext context) {
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
}
