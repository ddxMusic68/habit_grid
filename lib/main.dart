import 'package:flutter/material.dart';
import 'dart:math';
// change name to habitGrid

var habitItem1 = ValueNotifier<HabitItem>(
  HabitItem(
    name: 'Test Habit', 
    countUnit: "pushup",
    totalCount: 3,
    countIncrement: 1,
    squareCost: 1,
    boolList: [false, false, true, false]
  )
);

void main() {
  // Entry point of the application
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:
            MediaQuery.of(context).size.width >
                MediaQuery.of(context).size.height
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Overview(habitItem: habitItem1,), buildHabitPanel(context, habitItem1)],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Overview(habitItem: habitItem1,), buildHabitPanel(context, habitItem1)],
              ),
      ),
    );
  }
}

// ButtonSwitch
class ButtonSwitch extends StatefulWidget {
  final Color onColor;
  final Color offColor;
  final bool initialState;
  final ButtonStyle? style;
  final bool toggleOnce;

  const ButtonSwitch({
    super.key,
    this.onColor = Colors.green,
    this.offColor = Colors.red,
    this.initialState = false,
    this.style,
    this.toggleOnce = false,
  });

  @override
  State<ButtonSwitch> createState() => _ButtonSwitchState();
}

class _ButtonSwitchState extends State<ButtonSwitch> {
  late bool state;

  @override
  void initState() {
    super.initState();
    state = widget.initialState;
  }

  void _handlePress() {
    setState(() {
      state = !state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _handlePress,
      style:
          widget.style?.copyWith(
            backgroundColor: MaterialStateProperty.all(
              state ? widget.onColor : widget.offColor,
            ),
          ) ??
          ElevatedButton.styleFrom(
            backgroundColor: state ? widget.onColor : widget.offColor,
          ),
      child: null,
    );
  }
}

class HabitGrid extends StatelessWidget {
  final int sideLength;

  const HabitGrid({super.key, required this.sideLength});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:
          0.8 *
          min(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height,
          ),
      height:
          0.8 *
          min(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height,
          ),
      child: GridView.count(
        crossAxisCount: sideLength,
        children: List.generate(
          sideLength * sideLength,
          (index) => ButtonSwitch(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
          ),
        ),
      ),
    );
  }
}

// Habit Panel
Widget buildHabitPanel(BuildContext context, ValueNotifier<HabitItem> habitItem) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      HabitGrid(sideLength: 10),
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
          habitItem.value = habitItem.value.copyWith(totalCount: habitItem.value.totalCount + habitItem.value.countIncrement);

        },
      ),
    ],
  );
}

// Overview
class Overview extends StatefulWidget {
  final ValueNotifier<HabitItem> habitItem;

  const Overview({super.key, required this.habitItem});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<HabitItem>(
      valueListenable: widget.habitItem,
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
class HabitItem {
  final String name;
  final String countUnit;
  final int totalCount;
  final int countIncrement;
  final int squareCost;
  final List<bool> boolList;

  HabitItem({
    required this.name,
    required this.countUnit,
    required this.countIncrement,
    required this.totalCount,
    required this.squareCost,
    required this.boolList,
  });

  HabitItem copyWith({
    String? name,
    String? countUnit,
    int? totalCount,
    int? countIncrement,
    int? squareCost,
    List<bool>? boolList,
  }) {
    return HabitItem(
      name: name ?? this.name,
      countUnit: countUnit ?? this.countUnit,
      countIncrement: countIncrement ?? this.countIncrement,
      totalCount: totalCount ?? this.totalCount,
      squareCost: squareCost ?? this.squareCost,
      boolList: boolList ?? this.boolList,
    );
  }

  int get unused => ((totalCount - doneSquares*squareCost)/squareCost).floor();

  int get doneSquares => boolList.where((b) => b).length;

  int get totalSquares => boolList.length;

  String get progressText => '$doneSquares/$totalSquares';

  double get percentageComplete =>
      totalSquares > 0 ? (doneSquares / totalSquares) * 100 : 0.0;
}
