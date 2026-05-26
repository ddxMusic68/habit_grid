import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'habit_item.dart';
import 'widgets/habit_grid.dart';
import 'widgets/overview.dart';
import 'json.dart';

var habitItem1 = HabitItem(
  name: 'Test Habit', 
  totalCount: 3.0,
  countIncrement: 1.0,
  squareCost: 1.0,
  boolList: [false, true, false, false, true, false, false, true, true]
);

var habitItem2 = HabitItem(
  name: 'Test Habit 2', 
  totalCount: 5.0,
  countIncrement: 1.0,
  squareCost: 1.0,
  boolList: [false, false, false, false, false, false, false, false, false]
);

HabitItemList habitItemList = HabitItemList(items: [habitItem1, habitItem2]);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HabitItemList>.value(
      value: habitItemList,
      child: MaterialApp(
        home: Scaffold(
          body:
              MediaQuery.of(context).size.width >
                  MediaQuery.of(context).size.height
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Overview(), buildHabitPanel(context)],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [Overview(), buildHabitPanel(context)],
                  )
                ),
        ),
      ),
    );
  }
}

