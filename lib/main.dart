import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'habit_item.dart';
import 'pages/habit_page.dart';
import 'pages/new_habit_page.dart';
// import 'json.dart';

var habitItem1 = HabitItem(
  name: 'Test Habit',
  totalCount: 3.0,
  countIncrement: 1.0,
  squareCost: 1.0,
  boolList: [false, true, false, false, true, false, false, true, true],
);

var habitItem2 = HabitItem(
  name: 'Test Habit 2',
  totalCount: 5.0,
  countIncrement: 1.0,
  squareCost: 1.0,
  boolList: [false, false, false, false, false, false, false, false, false],
);

HabitItemList habitItemList1 = HabitItemList(items: [habitItem1, habitItem2]);

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  HabitItemList habitItemList = HabitItemList(items: []);
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    await habitItemList.load();
    setState(() {
      isLoading = false;
    });
  }

  void setCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return CircularProgressIndicator();
    }

    return ChangeNotifierProvider<HabitItemList>.value(
        value: habitItemList,
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(title: Text('Habit Grid')),
            body: IndexedStack(
        index: currentIndex,
        children: [
          habitPage(context),
          NewHabitPage(onHabitAdded: initData),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            for (int i=0; i<habitItemList.items.length; i++)
              ElevatedButton(
                onPressed: () {
                  habitItemList.setIndex(i);
                },
                child: Text(habitItemList.items[i].name),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setCurrentIndex((currentIndex + 1) % 2);
        },
        child: currentIndex == 0 ? Icon(Icons.add) : Icon(Icons.home),
      ),
    ),
  ),
);
  }
}
