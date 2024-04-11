// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:homeradar/constants/constants.dart';
import 'package:homeradar/models/upload_model.dart';
import 'package:homeradar/providers/address_provider.dart';
import 'package:homeradar/providers/auth_provider.dart';
import 'package:homeradar/screens/upload/build_form.dart';
import 'package:homeradar/screens/upload/upload_image.dart';
import 'package:homeradar/shared/address_picker.dart';
import 'package:homeradar/widgets/homeradar_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadForm extends StatefulWidget {
  const UploadForm({
    super.key,
  });

  @override
  State<UploadForm> createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController _title = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _duration = TextEditingController();

  final TextEditingController _rent = TextEditingController();
  final TextEditingController _security = TextEditingController();
  final TextEditingController _service = TextEditingController();
  final TextEditingController _total = TextEditingController();

  bool uploading = false;
  bool uploadToFire = false;
  bool noImages = false;
  final _formKey = GlobalKey<FormState>();

  List<String> propImages = [];

  List<XFile> imageFiles = [];
  final picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final List<String> items = [
    'Apartment',
    "Duplex",
    'Bungalow',
    'Villa',
    'Pent House',
  ];

  String? selectedValue;

  Future<void> _pickImages() async {
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        imageFiles.addAll(pickedFiles);
        noImages = false;
      });
    }
  }

  Future<void> _uploadImages() async {
    try {
      for (int index = 0; index < imageFiles.length; index++) {
        var imageFile = imageFiles[index];
        setState(() {
          uploadToFire = true;
        });

        UploadTask uploadTask = _storage
            .ref('properties/${_title.text}/image $index')
            .putFile(File(imageFile.path));

        TaskSnapshot snapshot = await uploadTask;

        // Get the download URL
        String downloadURL = await snapshot.ref.getDownloadURL();

        propImages.addAll([downloadURL]);
      }
      showSnack(context, "Property listed successfully");
      setState(() {
        uploadToFire = false;
        imageFiles.clear();
      });
    } on FirebaseException catch (e) {
      showSnack(context, "Failed to upload $e");
    }
  }

  @override
  void initState() {
    super.initState();

    _rent.addListener(calculateTotal);
    _security.addListener(calculateTotal);
    _service.addListener(calculateTotal);
  }

  @override
  void dispose() {
    _title.dispose();
    _address.dispose();
    _description.dispose();
    _duration.dispose();
    _rent.dispose();
    _security.dispose();
    _service.dispose();
    _total.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      Form(
        key: _formKey,
        child: SliverList(
            delegate: SliverChildListDelegate.fixed([
          buildForm("Title", _title, textInputAction: TextInputAction.done, hint: "Summerville Apartment"),
          // IMAGES
          const Text('Add Image', style: flargeText),
          uploadImage(_pickImages, imageFiles, uploading),
          noImages
              ? const Text(
                  "Please upload images",
                  style: TextStyle(
                      color: Color.fromARGB(255, 199, 39, 27), fontSize: 12),
                )
              : const Text(''),

          Container(
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(5)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Text(
                  'Select Type',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: items
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ))
                    .toList(),
                value: selectedValue,
                onChanged: (String? value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 140,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          AddressPicker(textEditingController: _address),
          buildForm(
            "Description",
            _description,
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            hint: "The property is a 3 bedroom..."
          ),
          buildForm("Duration", _duration,
              keyboardType: TextInputType.number,
              hint: "12 Months",
              suffixText: "Months"),
          buildForm(
            "Rent",
            _rent,
            keyboardType: TextInputType.number,
            prefixText: "\$",
            labelText: "\$"
          ),
          buildForm(
            "Security",
            _security,
            keyboardType: TextInputType.number,
            prefixText: "\$",
            labelText: "\$"
          ),
          buildForm(
            "Service Charge",
            _service,
            keyboardType: TextInputType.number,
            prefixText: "\$",
            labelText: "\$"
          ),
          buildForm(
            "Total",
            _total,
            readOnly: true,
            prefixText: "\$",
            labelText: "\$"
          ),

          Consumer<FireAuthProvider>(builder: (context, auth, _) {
            return Consumer<AddressProvider>(
                builder: (context, addressProvider, _) {
              return HomeRadarButton(
                text: "List Property",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (imageFiles.isEmpty) {
                      setState(() {
                        noImages = true;
                      });
                    } else if (imageFiles.isNotEmpty) {
                      setState(() {
                        noImages = false;
                      });
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                      _uploadImages().then((value) async {
                        try {
                          DocumentReference docRef = await firestore
                              .collection("properties")
                              .add(
                                UploadModel(
                                  propertyID: "",
                                  type: selectedValue.toString(),
                                  title: _title.text,
                                  description: _description.text,
                                  duration: _duration.text,
                                  rent: _rent.text,
                                  security: _security.text,
                                  service: _service.text,
                                  total: _total.text,
                                  imagesURL: propImages,
                                  author: auth.currentUser!.uid,
                                  latitude: addressProvider.latitude!,
                                  longitude: addressProvider.longitude!,
                                  addrDescription:
                                      addressProvider.description.toString(),
                                ).toFirestore(),
                              );
                          await docRef.update({"propertyID": docRef.id});
                          context.pop();
                          context.pop();
                        } catch (e) {
                          showSnack(context, "An error occured $e");
                        }
                      });
                    }
                  }
                },
              );
            });
          })
        ])),
      )
    ]);
  }

  void calculateTotal() {
    double rent = double.tryParse(_rent.text) ?? 0;
    double security = double.tryParse(_security.text) ?? 0;
    double service = double.tryParse(_service.text) ?? 0;

    double total = rent + security + service;

    _total.text = total.toString();
  }
}
