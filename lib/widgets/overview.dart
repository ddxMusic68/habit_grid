import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../habit_item.dart';

class Overview extends StatelessWidget {
  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitItemList>(
      builder: (context, habitItemList, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Name: ${habitItemList.currentItem.name}'),
            Text('Count: ${habitItemList.currentItem.totalCount}'),
            Text('Unused: ${habitItemList.currentItem.unused}'),
            Text(habitItemList.currentItem.progressText),
          ],
        );
      },
    );
  }
}
