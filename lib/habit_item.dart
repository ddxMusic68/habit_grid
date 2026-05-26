import 'package:flutter/material.dart';

class HabitItem with ChangeNotifier {
  String name;
  double totalCount;
  double countIncrement;
  double squareCost;
  List<bool> boolList;

  HabitItem({
    required this.name,
    required this.countIncrement,
    required this.totalCount,
    required this.squareCost,
    required this.boolList,
  });

  void update({
    String? name,
    String? countUnit,
    double? totalCount,
    double? countIncrement,
    double? squareCost,
    List<bool>? boolList,
  }) {
    this.name = name ?? this.name;
    this.countIncrement = countIncrement ?? this.countIncrement;
    this.totalCount = totalCount ?? this.totalCount;
    this.squareCost = squareCost ?? this.squareCost;
    this.boolList = boolList ?? this.boolList;
    notifyListeners();
  }

  void toggleSquare(int index) {
    if (index < 0 || index >= boolList.length) return;
    boolList[index] = !boolList[index];
    notifyListeners();
  }

  int get unused => ((totalCount - doneSquares*squareCost)/squareCost).floor();

  int get doneSquares => boolList.where((b) => b).length;

  int get totalSquares => boolList.length;

  String get progressText => '$doneSquares/$totalSquares';

  double get percentageComplete =>
      totalSquares > 0 ? (doneSquares / totalSquares) * 100 : 0.0;
}
