import 'package:flutter/material.dart';

class AddressProvider extends ChangeNotifier {
  double? _latitude;
  double? _longitude;
  String? _description;

  double? get latitude => _latitude;
  double? get longitude => _longitude;
  String? get description => _description;

  void setDetails(double lat, double lng, String descr) {
    _latitude = lat;
    _longitude = lng;
    _description = descr;
    notifyListeners();
  }
}
