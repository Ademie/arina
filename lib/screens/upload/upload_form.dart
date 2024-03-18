import 'package:arina/constants/constants.dart';
import 'package:arina/widgets/arina_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

class UploadForm extends StatefulWidget {
  const UploadForm({
    super.key,
  });

  @override
  State<UploadForm> createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
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
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverList(
          delegate: SliverChildListDelegate.fixed([
        const Text('Title', style: flargeText),
        TextFormField(),
        const SizedBox(
          height: 25,
        ),
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
        const Text('Address', style: flargeText),
        TextFormField(),
        const SizedBox(
          height: 25,
        ),
        const Text('Description', style: flargeText),
        TextFormField(),
        const SizedBox(
          height: 25,
        ),
        const Text('Duration', style: flargeText),
        TextFormField(),
        const SizedBox(
          height: 25,
        ),
        const Text('Rent', style: flargeText),
        TextFormField(),
        const SizedBox(
          height: 25,
        ),
        const Text('Security', style: flargeText),
        TextFormField(),
        const SizedBox(
          height: 25,
        ),
        const Text('Service Charge', style: flargeText),
        TextFormField(),
        const SizedBox(
          height: 25,
        ),
        const Text('Total', style: flargeText),
        TextFormField(
          readOnly: true,
        ),
        const SizedBox(
          height: 25,
        ),
        ArinaButton(
          text: "List Property",
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ]))
    ]);
  }
}
