import 'package:flutter/material.dart';
import 'package:money_filler/json.dart';
import 'package:flutter/services.dart';

class NewHabitPage extends StatefulWidget {
  final Function onHabitAdded;
  final Function setCurrentIndex;

  const NewHabitPage({super.key, required this.onHabitAdded, required this.setCurrentIndex});

  @override
  State<NewHabitPage> createState() => _NewHabitPageState();
}

class _NewHabitPageState extends State<NewHabitPage> {
  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _countIncrementController = TextEditingController();
  final TextEditingController _squareCostController = TextEditingController();
  final TextEditingController _totalSquaresController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Habit Name'),
            ),
            TextField(
              controller: _countIncrementController,
              decoration: InputDecoration(labelText: 'Count Increment'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                ],
            ),
            TextField(
              controller: _squareCostController,
              decoration: InputDecoration(labelText: 'Square Cost'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                ],
            ),
            TextField(
              controller: _totalSquaresController,
              decoration: InputDecoration(labelText: 'total squares'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                ],
            ),
            SizedBox(height: 20), // gap
            SizedBox(
              width: double.infinity, // full width button
              child:
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isEmpty ||
                    _countIncrementController.text.isEmpty ||
                    _squareCostController.text.isEmpty ||
                    _totalSquaresController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields'), backgroundColor: Color(0xFFEF5350),),
                  );
                  return;
                }
                if (double.tryParse(_countIncrementController.text)! <= 0 || double.tryParse(_squareCostController.text)! <= 0 || int.tryParse(_totalSquaresController.text)! <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter positive values'), backgroundColor: Color(0xFFEF5350),),
                  );
                  return;
                }
                if (double.tryParse(_countIncrementController.text) == null || double.tryParse(_squareCostController.text) == null || int.tryParse(_totalSquaresController.text) == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter valid numbers'), backgroundColor: Color(0xFFEF5350),),
                  );
                  return;
                }
                loadJSON('storage.json').then((data) {
                  data.add({
                    'totalCount': 0.0,
                    'name': _nameController.text,
                    'countIncrement':
                        double.tryParse(_countIncrementController.text) ?? 0.0,
                    'squareCost':
                        double.tryParse(_squareCostController.text) ?? 0.0,
                    'boolList': List.filled(
                      int.tryParse(_totalSquaresController.text) ?? 0,
                      false,
                    ),
                  });
                  saveJSON('storage.json', data);
                  widget.onHabitAdded();
                  widget.setCurrentIndex();
                });
              },
              child: Text('Add Habit'),
            ),
            )
          ],
        ),
      ),
    );
  }
}
