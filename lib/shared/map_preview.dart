import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cached_tile_provider/flutter_map_cached_tile_provider.dart';
import 'package:latlong2/latlong.dart';

class MapPreview extends StatelessWidget {
  const MapPreview({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 400,
      padding: const EdgeInsets.all(25),
      child: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(latitude, longitude),
          initialZoom: 12.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
            tileProvider: CachedTileProvider(),
          ),
          MarkerLayer(markers: [
            Marker(
              point: LatLng(latitude, longitude),
              child: const Icon(
                Icons.location_on,
                color: Colors.black,
                size: 50.0,
              ),
            )
          ])
        ],
      ),
    );
  }
}

class MapDialog extends StatelessWidget {
  const MapDialog({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(latitude, longitude),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
            tileProvider: CachedTileProvider(),
          ),
          MarkerLayer(markers: [
            Marker(
              point: LatLng(latitude, longitude),
              child: const Icon(
                Icons.location_on,
                color: Colors.black,
                size: 50.0,
              ),
            )
          ])
        ],
      ),
    );
  }
}
