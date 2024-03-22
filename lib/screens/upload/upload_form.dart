import 'package:arina/constants/constants.dart';
import 'package:arina/models/upload_model.dart';
import 'package:arina/providers/auth_provider.dart';
import 'package:arina/widgets/arina_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
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

  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  final List<XFile> imageFileList = [];
  bool _uploading = false;

  Future<void> selectImages() async {
    setState(() {
      _uploading = true;
    });

    final List<XFile> selectedImages = await _imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      setState(() {
        imageFileList.addAll(selectedImages);
      });
    }

    setState(() {
      _uploading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _rent.addListener(calculateTotal);
    _security.addListener(calculateTotal);
    _service.addListener(calculateTotal);
  }

  void calculateTotal() {
    double rent = double.tryParse(_rent.text) ?? 0;
    double security = double.tryParse(_security.text) ?? 0;
    double service = double.tryParse(_service.text) ?? 0;

    double total = rent + security + service;

    _total.text = total.toString();
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
          buildForm("Title", _title),
          // IMAGES
          const Text('Add Image', style: flargeText),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: IconButton(
                    onPressed: selectImages,
                    icon: const Icon(
                      Ionicons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 80,
                  width: 800,
                  child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 10,
                          ),
                      itemCount: imageFileList.length + (_uploading ? 1 : 0),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        if (index == imageFileList.length) {
                          return _uploading
                              ? Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.white,
                                  )),
                                )
                              : Container();
                        } else {
                          return Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: AssetImage(
                                      imageFileList[index].path,
                                    ),
                                    fit: BoxFit.cover)),
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
          buildForm("Address", _address),
          buildForm("Description", _description),
          buildForm("Duration", _duration),
          buildForm("Rent", _rent),
          buildForm("Security", _security),
          buildForm("Service Charge", _service),
          buildForm("Total", _total, readOnly: true),
          Consumer<FireAuthProvider>(builder: (context, auth, _) {
            return ArinaButton(
              text: "List Property",
              isLoading: auth.isLoading,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    firestore
                        .collection("users")
                        .doc(auth.currentUser!.uid)
                        .collection("properties")
                        .add(
                          UploadModel(
                            title: _title.text,
                            propAddress: _address.text,
                            description: _description.text,
                            duration: _duration.text,
                            rent: _rent.text,
                            security: _security.text,
                            service: _service.text,
                            total: _total.text,
                          ).toFirestore(),
                        );
                    auth.isLoading = true;
                    Future.delayed(const Duration(seconds: 2), () {
                      showSnack(context, "Property listed successfully");
                      context.pop();
                    });
                  } catch (e) {
                    showSnack(context, "An error occured $e");
                  }
                }
                // Navigator.of(context).pop();
              },
            );
          })
        ])),
      )
    ]);
  }
}

Widget buildForm(String label, TextEditingController controller,
    {bool readOnly = false, onChanged}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: flargeText),
      TextFormField(
        readOnly: readOnly,
        controller: controller,
        onChanged: onChanged,
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
