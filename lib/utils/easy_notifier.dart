import 'package:flutter/material.dart';

class EasyNotifier extends ChangeNotifier {
  void notify([VoidCallback? action]) {
    if (action != null) action();
    notifyListeners();
  }
}
