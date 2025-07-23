import 'package:flutter/material.dart';

class NinersLogic with ChangeNotifier {
  List<bool> fields = [true, true, true, true, true, true, true, true, true];
  bool isWinner = false;

  void change(int index) {
    fields[index] = !fields[index];
    if (index == 4) {
      fields[3] = !fields[3];
      fields[1] = !fields[1];
      fields[5] = !fields[5];
      fields[7] = !fields[7];
    } else if (index == 3 || index == 5) {
      fields[index - 3] = !fields[index - 3];
      fields[index + 3] = !fields[index + 3];

      index == 3
          ? fields[index + 1] = !fields[index + 1]
          : fields[index - 1] = !fields[index - 1];
    } else if (index == 1 || index == 7) {
      fields[index] = !fields[index];
      fields[index - 1] = !fields[index - 1];
      fields[index + 1] = !fields[index + 1];

      index == 1
          ? fields[index + 3] = !fields[index + 3]
          : fields[index - 3] = !fields[index - 3];
    } else if (index == 0 || index == 2 || index == 6 || index == 8) {
      if (index == 0 || index == 6) {
        fields[index + 1] = !fields[index + 1];
        if (index == 0) {
          fields[index + 3] = !fields[index + 3];
        }
        if (index == 6) {
          fields[index - 3] = !fields[index - 3];
        }
      }
      if (index == 2 || index == 8) {
        fields[index - 1] = !fields[index - 1];
        if (index == 2) {
          fields[index + 3] = !fields[index + 3];
        }
        if (index == 8) {
          fields[index - 3] = !fields[index - 3];
        }
      }
    }
    if (!fields.contains(false)) {
      isWinner = true;
    }
    notifyListeners();
  }
}
