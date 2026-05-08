import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

var habitItem1 = HabitItem(
  name: 'Test Habit', 
  countUnit: "pushup",
  totalCount: 3,
  countIncrement: 1,
  squareCost: 1,
  boolList: [false, true, false, false, true, false, false, true, true]
);

void main() {
  // Entry point of the application
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HabitItem>.value(
      value: habitItem1,
      child: MaterialApp(
        home: Scaffold(
          body:
              MediaQuery.of(context).size.width >
                  MediaQuery.of(context).size.height
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Overview(), buildHabitPanel(context, habitItem1)],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [Overview(), buildHabitPanel(context, habitItem1)],
                  )
                ),
        ),
      ),
    );
  }
}

// ButtonSwitch
class ButtonSwitch extends StatelessWidget {
  final bool state;
  final VoidCallback onPressed;

  final Color onColor;
  final Color offColor;
  final ButtonStyle? style;

  const ButtonSwitch({
    super.key,
    this.style,
    this.onColor = Colors.green,
    this.offColor = Colors.red,
    required this.state,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style:
        style?.copyWith(
          backgroundColor: MaterialStateProperty.all(
            state ? onColor : offColor,
          ),
        ) ??
        ElevatedButton.styleFrom(
          backgroundColor: state ? onColor : offColor,
        ),
      child: null,
    );
  }
}

class HabitGrid extends StatefulWidget {
  final HabitItem habitItem;
  final int sideLength;

  const HabitGrid({
    super.key, 
    required this.habitItem,
    required this.sideLength,
  });

  @override
  State<HabitGrid> createState() => _HabitGridState();
}

class _HabitGridState extends State<HabitGrid> {

  @override
  void initState() {
    super.initState();
  }

  void toggleIndex(int index) {
    if (widget.habitItem.boolList[index] == true || widget.habitItem.unused <= 0) return;
    setState(() {
      widget.habitItem.boolList[index] = !widget.habitItem.boolList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final HabitItem habitItem = widget.habitItem;
    final int sideLength = widget.sideLength;

    double size = 0.8 * min(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );
    return SizedBox(
      width: size,
      height: size,
      child: GridView.count(
        crossAxisCount: sideLength,
        children: List.generate(
          sideLength * sideLength,
          (index) => ButtonSwitch(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            state: habitItem.boolList[index],
            onPressed: () => {
              toggleIndex(index),
              habitItem.update(),
            },
          ),
        ),
      ),
    );
  }
}

// Habit Panel
Widget buildHabitPanel(BuildContext context, HabitItem habitItem) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,

    children: [
      HabitGrid(habitItem: habitItem1, sideLength: sqrt(habitItem1.boolList.length).toInt()),
      SizedBox(height: 20),
      IconButton(
        icon: Icon(Icons.add),
        constraints: BoxConstraints(
          minWidth:
              0.8 *
              min(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height,
              ),
        ),
        style: IconButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        onPressed: () {
          habitItem.update(totalCount: habitItem.totalCount + habitItem.countIncrement);
        },
      ),
    ],
  );
}

// Overview
class Overview extends StatelessWidget {
  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitItem>(
      builder: (context, habitItem, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Name: ${habitItem.name}'),
            Text('Count: ${habitItem.totalCount}'),
            Text('Unused: ${habitItem.unused}'),
            Text(habitItem.progressText),
          ],
        );
      },
    );
  }
}

// Data Classes
class HabitItem with ChangeNotifier {
  String name;
  String countUnit;
  int totalCount;
  int countIncrement;
  int squareCost;
  List<bool> boolList;

  HabitItem({
    required this.name,
    required this.countUnit,
    required this.countIncrement,
    required this.totalCount,
    required this.squareCost,
    required this.boolList,
  });

  void update({
    String? name,
    String? countUnit,
    int? totalCount,
    int? countIncrement,
    int? squareCost,
    List<bool>? boolList,
  }) {
    this.name = name ?? this.name;
    this.countUnit = countUnit ?? this.countUnit;
    this.countIncrement = countIncrement ?? this.countIncrement;
    this.totalCount = totalCount ?? this.totalCount;
    this.squareCost = squareCost ?? this.squareCost;
    this.boolList = boolList ?? this.boolList;
    notifyListeners();
  }

  int get unused => ((totalCount - doneSquares*squareCost)/squareCost).floor();

  int get doneSquares => boolList.where((b) => b).length;

  int get totalSquares => boolList.length;

  String get progressText => '$doneSquares/$totalSquares';

  double get percentageComplete =>
      totalSquares > 0 ? (doneSquares / totalSquares) * 100 : 0.0;
}
