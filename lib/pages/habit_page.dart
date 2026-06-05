import 'package:flutter/material.dart';
import '../widgets/habit_grid.dart';
import '../widgets/overview.dart';
import '../habit_item.dart';
import 'package:provider/provider.dart';

Widget habitPage(BuildContext context) {
  return Consumer<HabitItemList>(
    builder: (context, habitItemList, child) {
      if (habitItemList.items.isEmpty) {
        return Center(child: Text('No habits yet. Add one!'));
      }
      return MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
      ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Overview(), buildHabitPanel(context)],
        )
      : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Overview(), buildHabitPanel(context)],
          ),
        );
    } 
  );

}