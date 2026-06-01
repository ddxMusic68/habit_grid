import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import './habit_item.dart';

void main() async {
}

Future<File> _localFile(String fileName) async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    final exeDir = File(Platform.resolvedExecutable).parent.path;
    final filePath = p.join(exeDir, fileName);
    return File(filePath);
  }
  else {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$fileName');
  }
}

Future<List<Map<String, dynamic>>> loadJSON(String fileName) async {
  try {
    final file = await _localFile(fileName);

    if (!await file.exists()) {
      return [];
    }

    final contents = await file.readAsString();
    final decoded = jsonDecode(contents);

    return List<Map<String, dynamic>>.from(decoded);
  } catch (e) {
    return [];
  }
}
Future<void> saveJSON(String fileName, List<Object> json) async {
  final file = await _localFile(fileName);
  
  final jsonString = jsonEncode(json);

  await file.writeAsString(jsonString);
}

Future<List<HabitItem>> loadHabitItems() async {
  final jsonList = await loadJSON('storage.json');
  
  final habitItems = jsonList.map((json) => HabitItem(
    name: json['name'],
    totalCount: json['totalCount'],
    countIncrement: json['countIncrement'],
    squareCost: json['squareCost'],
    boolList: List<bool>.from(json['boolList']),
  )).toList();
  return habitItems;
}

Future<void> saveHabitItems(List<HabitItem> items) async {
  final jsonList = items.map((item) => {
    "totalCount": item.totalCount,
    'name': item.name,
    'countIncrement': item.countIncrement,
    'squareCost': item.squareCost,
    'boolList': item.boolList,
  }).toList();

  await saveJSON('storage.json', jsonList);
}