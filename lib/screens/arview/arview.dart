import 'dart:io';
import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart';

class ArView extends StatefulWidget {
  const ArView({super.key});

  @override
  State<ArView> createState() =>
      Platform.isAndroid ? ArCoreState() : ArKitState();
}

class ArCoreState extends State<ArView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ArKitState extends State<ArView> {
  late ARKitController arkitController;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onARKitViewCreated(ARKitController arkitController) {
      this.arkitController = arkitController;
      final node = ARKitNode(
          geometry: ARKitSphere(radius: 0.1), position: Vector3(0, 0, -0.5));
      this.arkitController.add(node);
    }

    return Scaffold(
        appBar: AppBar(title: const Text('ARKit in Flutter')),
        body: ARKitSceneView(
          onARKitViewCreated: onARKitViewCreated,
          enableTapRecognizer: true,
          enablePinchRecognizer: true,
          enablePanRecognizer: true,
          enableRotationRecognizer: true,
        ));
  }
}
