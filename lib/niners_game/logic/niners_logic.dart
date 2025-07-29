import 'package:flutter/material.dart';
import 'dart:math';

class NinersLogic with ChangeNotifier {
  List<bool> fields = List.generate(9, (_) => true);
  bool isWinner = false;

  final Map<int, List<int>> _toggleMap = {
    0: [0, 1, 3],
    1: [1, 0, 2, 4],
    2: [2, 1, 5],
    3: [3, 0, 6, 4],
    4: [4, 1, 3, 5, 7],
    5: [5, 2, 8, 4],
    6: [6, 3, 7],
    7: [7, 6, 8, 4],
    8: [8, 5, 7],
  };

  Map<int, List<List<bool>>> levels = {
    1: [], // Easy
    2: [], // Medium
    3: [], // Hard
  };

  final Random _random = Random();

  NinersLogic() {
    generateAllLevels(); 
  }


  void generateAllLevels() {
    levels[1] = List.generate(3, (_) => _generatePuzzle(2)); // Easy: 2 moves
    levels[2] = List.generate(3, (_) => _generatePuzzle(4)); // Medium: 4 moves
    levels[3] = List.generate(3, (_) => _generatePuzzle(6)); // Hard: 6+ moves
  }


  List<bool> _generatePuzzle(int moves) {
    List<bool> puzzle = List.generate(9, (_) => true);
    for (int i = 0; i < moves; i++) {
      int index = _random.nextInt(9);
      for (int toggle in _toggleMap[index]!) {
        puzzle[toggle] = !puzzle[toggle];
      }
    }
    return puzzle;
  }

  void loadLevel(List<bool> levelState) {
    fields = List.from(levelState);
    isWinner = !fields.contains(false);
    notifyListeners();
  }

  void change(int index) {
    for (int i in _toggleMap[index]!) {
      fields[i] = !fields[i];
    }
    isWinner = !fields.contains(false);
    notifyListeners();
  }
}
