import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

SingleChildScrollView uploadImage(
    Function() selectImages, List<XFile> imageFileList, bool uploading) {
  return SingleChildScrollView(
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
              itemCount: imageFileList.length + (uploading ? 1 : 0),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index == imageFileList.length) {
                  return uploading
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
  );
}
