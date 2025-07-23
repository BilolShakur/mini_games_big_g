import 'package:flutter/material.dart';

class NinersLogic with ChangeNotifier {
  List<bool> fields = [true, true, true, true, true, true, true, true, true];

  void change(int index) {
    if (index == 4) {
      fields[index] = !fields[index];
      fields[3] = !fields[3];
      fields[1] = !fields[1];
      fields[5] = !fields[5];
      fields[7] = !fields[7];
    } else {
      fields[index] = !fields[index];
    }
    notifyListeners();
  }
}
