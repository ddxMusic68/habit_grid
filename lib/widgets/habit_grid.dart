import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../habit_item.dart';
import 'dart:math';

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
          ElevatedButton.styleFrom(backgroundColor: state ? onColor : offColor),
      child: null,
    );
  }
}

class HabitGrid extends StatelessWidget {
  const HabitGrid({super.key});

  @override
  Widget build(BuildContext context) {
      return Consumer<HabitItemList>(
        builder: (context, habitItemList, child) {
          final int sideLength = habitItemList.currentItem().totalSquares > 0
              ? sqrt(habitItemList.currentItem().totalSquares).ceil()
              : 1;
          double size =
              0.8 *
              min(
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
                (index) => index>=habitItemList.currentItem().totalSquares
                    ? Container() // Empty cell for out-of-range indices
                    :
                ButtonSwitch(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  state: habitItemList.currentItem().boolList[index],
                  onPressed: () => {
                    habitItemList.toggleCurrentSquare(index),
                    habitItemList.save()
                  },
                ),
              ),
            ),
          );
        },
      );
  }
}

// Habit Panel
Widget buildHabitPanel(BuildContext context) {
  return Consumer<HabitItemList>(
    builder: (context, habitItemList, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          HabitGrid(),
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
              habitItemList.updateCurrentItem(
                totalCount: habitItemList.currentItem().totalCount + habitItemList.currentItem().countIncrement,
              );
              habitItemList.save();
            },
          ),
        ],
      );
    },
  );
}
