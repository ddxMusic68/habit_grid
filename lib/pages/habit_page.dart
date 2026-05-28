import 'package:flutter/material.dart';
import '../widgets/habit_grid.dart';
import '../widgets/overview.dart';

Widget habitPage(BuildContext context) {
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