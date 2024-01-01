import 'dart:io';
import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

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
  ARKitReferenceNode? node;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('ARKit in Flutter')),
        body: ARKitSceneView(
          onARKitViewCreated: onARKitViewCreated,
          enableTapRecognizer: true,
          enablePinchRecognizer: true,
          enablePanRecognizer: true,
          enableRotationRecognizer: true,
          showFeaturePoints: true,
          planeDetection: ARPlaneDetection.horizontal,
        ));
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    arkitController.addCoachingOverlay(CoachingOverlayGoal.horizontalPlane);
    arkitController.onAddNodeForAnchor = _handleAddAnchor;
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (anchor is ARKitPlaneAnchor) {
      _addPlane(arkitController, anchor);
    }
  }

  void _addPlane(ARKitController controller, ARKitPlaneAnchor anchor) {
    if (node != null) {
      controller.remove(node!.name);
    }
    node = ARKitReferenceNode(
      url: 'models.scnassets/stairs.dae',
      scale: vector.Vector3.all(0.3),
    );
    controller.add(node!, parentNodeName: anchor.nodeName);
  }
}
