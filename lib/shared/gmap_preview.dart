import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMapPreview extends StatefulWidget {
  const GMapPreview({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  State<GMapPreview> createState() => GMapPreviewState();
}

class GMapPreviewState extends State<GMapPreview> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 400,
      padding: const EdgeInsets.all(25),
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude, widget.longitude),
          zoom: 14.4746,
        ),
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          setState(() {
            markers.add(
              Marker(
                markerId: const MarkerId('MyMarker'),
                position: LatLng(widget.latitude, widget.longitude),
                infoWindow: const InfoWindow(
                  title: 'Your Location',
                  snippet: 'This is your location.',
                ),
              ),
            );
          });
        },
      ),
    );
  }
}

class GMapDialog extends StatefulWidget {
  const GMapDialog(
      {super.key, required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  @override
  State<GMapDialog> createState() => _GMapDialogState();
}

class _GMapDialogState extends State<GMapDialog> {
  final Set<Marker> _markers = {};
  late final Completer<GoogleMapController> _controller;

  @override
  void initState() {
    super.initState();
    _controller = Completer<GoogleMapController>();
    _markers.add(
      Marker(
        markerId: const MarkerId('PropertyMarker'),
        position: LatLng(widget.latitude, widget.longitude),
        infoWindow: const InfoWindow(
          title: 'Your Location',
          snippet: 'This is your location.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude, widget.longitude),
          zoom: 14.4746,
        ),
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
