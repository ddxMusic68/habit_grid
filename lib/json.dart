import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

void main() async {
}

const Map<String, dynamic> defaultSettings = {
  "work": 20,
  "notes": 5,
  "rest": 10,
  "pages": 1
};

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

Future<Map<String, dynamic>> loadSettings(String fileName) async {
  try {
    final file = await _localFile(fileName);

    if (!await file.exists()) {
      return defaultSettings; // return default settings
    }

    final contents = await file.readAsString();
    return jsonDecode(contents);
  } catch (e) {
    return defaultSettings;
  }
}

Future<void> saveSettings(String fileName, Map<String, dynamic> json) async {
  final file = await _localFile(fileName);

  final jsonString = jsonEncode(json);

  await file.writeAsString(jsonString);
}