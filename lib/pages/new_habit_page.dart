import 'package:flutter/material.dart';
import 'package:money_filler/json.dart';
import 'dart:math';

class NewHabitPage extends StatefulWidget {
  final Function onHabitAdded;

  const NewHabitPage({super.key, required this.onHabitAdded});

  @override
  State<NewHabitPage> createState() => _NewHabitPageState();
}

class _NewHabitPageState extends State<NewHabitPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _countIncrementController = TextEditingController();
  final TextEditingController _squareCostController = TextEditingController();
  final TextEditingController _squaresPerRowController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Habit Name',
          ),
        ),
        TextField(
          controller: _countIncrementController,
          decoration: InputDecoration(
            labelText: 'Count Increment',
          ),
        ),
        TextField(
          controller: _squareCostController,
          decoration: InputDecoration(
            labelText: 'Square Cost',
          ),
        ),
        TextField(
          controller: _squaresPerRowController,
          decoration: InputDecoration(
            labelText: 'Squares per Row',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            loadJSON('storage.json').then((data) {
              int boolListLength = pow((num.tryParse(_squaresPerRowController.text) ?? 0), 2).toInt();
              data.add({
                'name': _nameController.text,
                'countIncrement': double.tryParse(_countIncrementController.text) ?? 0.0,
                'squareCost': double.tryParse(_squareCostController.text) ?? 0.0,
                'boolList': List.filled(boolListLength, false),
              });
              saveJSON('storage.json', data);
              widget.onHabitAdded();
            });
          },
          child: Text('Add Habit'),
        ),
      ],
    );
  }
}
