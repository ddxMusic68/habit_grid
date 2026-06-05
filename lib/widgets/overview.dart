import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../habit_item.dart';

class Overview extends StatelessWidget {
  static const double fontSize = 24;
  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitItemList>(
      builder: (context, habitItemList, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Name: ${habitItemList.currentItem().name}', style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)),
            Text('Count: ${habitItemList.currentItem().totalCount}', style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)),
            Text('Unused: ${habitItemList.currentItem().unused}', style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)),
            Text('percent: ${habitItemList.currentItem().percentageComplete.toStringAsFixed(2)}%', style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)),
            Text(habitItemList.currentItem().progressText, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)),
          ],
        );
      },
    );
  }
}
