import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'habit_item.dart';
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
        ElevatedButton.styleFrom(
          backgroundColor: state ? onColor : offColor,
        ),
      child: null,
    );
  }
}

class HabitGrid extends StatelessWidget {
  final HabitItem habitItem;

  const HabitGrid({super.key, required this.habitItem});

  @override
  Widget build(BuildContext context) {
    ChangeNotifierProvider<HabitItem>.value(
      value: habitItem,
      child: Consumer<HabitItem>(
        builder: (context, habitItem, child) {
          final int sideLength = habitItem.totalSquares > 0 ? sqrt(habitItem.totalSquares).toInt() : 1;
          return Text(sideLength.toString());
        },
      ),
    );

    return CircularProgressIndicator();

    // double size = 0.8 * min(
    //   MediaQuery.of(context).size.width,
    //   MediaQuery.of(context).size.height,
    // );
    // return SizedBox(
    //   width: size,
    //   height: size,
    //   child: GridView.count(
    //     crossAxisCount: sideLength,
    //     children: List.generate(
    //       sideLength * sideLength,
    //       (index) => ButtonSwitch(
    //         style: ElevatedButton.styleFrom(
    //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    //         ),
    //         state: habitItem.boolList[index],
    //         onPressed: () => {
    //           toggleIndex(index),
    //           habitItem.update(),
    //         },
    //       ),
    //     ),
    //   ),
    // );
  }
}
