import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import 'habit_item.dart';
import 'habit_grid.dart';
import 'json.dart';

var habitItem1 = HabitItem(
  name: 'Test Habit', 
  totalCount: 3.0,
  countIncrement: 1.0,
  squareCost: 1.0,
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
