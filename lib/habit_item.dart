import 'package:flutter/material.dart';
import './json.dart';
import 'dart:math';

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
    if (index < 0 || index >= boolList.length || boolList[index]) return;
    if (totalCount - doneSquares * squareCost < squareCost) return;
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

class HabitItemList with ChangeNotifier {
  List<HabitItem> items;
  int currentIndex = 0;

  HabitItemList({required this.items});

  HabitItem currentItem() {
    if (items.isEmpty) {
      return HabitItem(
        name: 'New Habit',
        totalCount: 0,
        countIncrement: 1,
        squareCost: 1,
        boolList: [false],
      );
    }
    return items[currentIndex];
  }

  HabitItem deleteItem(int index) {
    if (index < 0 || index >= items.length) {
      throw RangeError('Index out of range');
    }
    HabitItem removedItem = items.removeAt(index);
    if (currentIndex >= items.length) {
      currentIndex = max(0, items.length - 1);
    }
    notifyListeners();
    return removedItem;
  }

  void setIndex(int index) {
    if (index < 0 || index >= items.length) return;
    currentIndex = index;
    notifyListeners();
  }

  void toggleCurrentSquare(int index) {
    currentItem().toggleSquare(index);
    notifyListeners();
  }

  void updateCurrentItem({
    String? name,
    String? countUnit,
    double? totalCount,
    double? countIncrement,
    double? squareCost,
    List<bool>? boolList,
  }) {
    currentItem().update(
      name: name,
      countIncrement: countIncrement,
      totalCount: totalCount,
      squareCost: squareCost,
      boolList: boolList,
    );
    notifyListeners();
  }

  Future<void> load() async {
    final data = await loadHabitItems();
    items = data;
    notifyListeners();
  }

  Future<void> save() async {
    await saveHabitItems(items);
  }
}