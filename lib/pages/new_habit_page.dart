import 'package:flutter/material.dart';
import 'package:money_filler/json.dart';

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
  final TextEditingController _totalSquaresController = TextEditingController();

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
          controller: _totalSquaresController,
          decoration: InputDecoration(
            labelText: 'total squares',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            loadJSON('storage.json').then((data) {
              data.add({
                'totalCount': 0.0,
                'name': _nameController.text,
                'countIncrement': double.tryParse(_countIncrementController.text) ?? 0.0,
                'squareCost': double.tryParse(_squareCostController.text) ?? 0.0,
                'boolList': List.filled(int.tryParse(_totalSquaresController.text) ?? 0, false),
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
