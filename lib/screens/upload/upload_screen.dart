import 'package:arina/constants/constants.dart';
import 'package:arina/screens/upload/upload_form.dart';
import 'package:arina/shared/app_scaffold.dart';
import 'package:arina/widgets/arina_button.dart';
import 'package:flutter/material.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
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
