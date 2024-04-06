// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:arina/constants/constants.dart';
import 'package:arina/models/upload_model.dart';
import 'package:arina/providers/auth_provider.dart';
import 'package:arina/screens/upload/upload_image.dart';
import 'package:arina/shared/address_picker.dart';
import 'package:arina/widgets/arina_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

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
  Uuid propertyID = const Uuid();

  List<String> propImages = [];

  List<XFile> imageFiles = [];
  final picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

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
          buildForm("Title", _title, textInputAction: TextInputAction.done),
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

          const AddressPicker(),
          buildForm("Description", _description,
              keyboardType: TextInputType.multiline, maxLines: 5),
          buildForm("Duration", _duration, keyboardType: TextInputType.number),
          buildForm("Rent", _rent, keyboardType: TextInputType.number),
          buildForm("Security", _security, keyboardType: TextInputType.number),
          buildForm("Service Charge", _service,
              keyboardType: TextInputType.number),
          buildForm("Total", _total, readOnly: true),
          Consumer<FireAuthProvider>(builder: (context, auth, _) {
            return ArinaButton(
              text: "List Property",
              isLoading: uploadToFire,
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
                    _uploadImages().then((value) {
                      try {
                        firestore.collection("properties").add(
                              UploadModel(
                                propertyID: propertyID.v4().toString(),
                                title: _title.text,
                                propAddress: _address.text,
                                description: _description.text,
                                duration: _duration.text,
                                rent: _rent.text,
                                security: _security.text,
                                service: _service.text,
                                total: _total.text,
                                imagesURL: propImages,
                                author: currentUserID,
                              ).toFirestore(),
                            );
                        context.pop();
                      } catch (e) {
                        showSnack(context, "An error occured $e");
                      }
                    });
                  }
                }
              },
            );
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

Widget buildForm(
  String label,
  TextEditingController controller, {
  bool readOnly = false,
  onChanged,
  keyboardType,
  maxLines,
  textInputAction,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: flargeText),
      TextFormField(
        readOnly: readOnly,
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter some text";
          }
          return null;
        },
      ),
      const SizedBox(height: 25),
    ],
  );
}
