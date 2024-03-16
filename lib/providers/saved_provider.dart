import 'dart:collection';

import 'package:arina/models/product_model.dart';
import 'package:flutter/material.dart';

class SavedProvider extends ChangeNotifier {
  final List<ProductModel> _houses = [];

  UnmodifiableListView<ProductModel> get houses =>
      UnmodifiableListView(_houses);

  void add(ProductModel house) {
    if (_houses.contains(house)) {
      _houses.remove(house);
    } else {
      _houses.add(house);
    }
  }

  void removeAll() {
    _houses.clear();
    notifyListeners();
  }
}
