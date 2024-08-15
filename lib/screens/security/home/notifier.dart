import 'package:flutter/material.dart';

class Notifier with ChangeNotifier {
  final Map<DateTime, bool> _presenceData = {};

  Map<DateTime, bool> get item => _presenceData;

  void add(Map<DateTime, bool> data) {
    _presenceData.addAll(data);
    notifyListeners();
  }
}
