import 'package:arina/constants/constants.dart';
import 'package:arina/shared/app_scaffold.dart';
import 'package:arina/widgets/arina_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "List Property",
      body: SingleChildScrollView(
        child: SizedBox(
          height: 800,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    "You must complete KYC to list a property",
                    style: nsmallText,
                  ),
                ),
                const Center(
                  child: Text(
                    "please do so if you haven't",
                    style: nsmallText,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                    child: ArinaButton(
                  text: 'List Property',
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) {
                          return const ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            child: FractionallySizedBox(
                              heightFactor: 0.9,
                              child: Scaffold(
                                body: Padding(
                                  padding: EdgeInsets.all(25),
                                  child: UploadForm(),
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  width: 220,
                  height: 60,
                )),
              ]),
        ),
      ),
    );
  }
}

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
    print(_uploading);
    final List<XFile> selectedImages = await _imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      setState(() {
        imageFileList.addAll(selectedImages);
      });
    }

    setState(() {
      _uploading = false;
    });
    print(_uploading);
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
