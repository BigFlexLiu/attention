import 'dart:convert';
import 'dart:io';

import 'package:attention/models/task_definition.dart';
import 'package:path_provider/path_provider.dart';

import '../models/settings.dart';
import '../theme/theme.dart';

Future<File> get _settingsFile async {
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  return File('$path/settings.json');
}

Future<File> writeSettings(Settings settings) async {
  final file = await _settingsFile;

  return file.writeAsString(jsonEncode(settings));
}

Future<Settings> readSettings() async {
  const defaultSetting = Settings(
      taskDefinition: TaskDefinition(
        defineSteps: true,
        defineProblems: true,
        defineReflect: true,
        definePromise: true,
      ),
      painterTheme: PainterTheme.circle);
  try {
    final file = await _settingsFile;

    if (!await file.exists()) {
      return defaultSetting;
    }

    final String contents = await file.readAsString();
    Settings settings = Settings.fromJson(jsonDecode(contents));

    return settings;
  } catch (e) {
    return defaultSetting;
  }
}

Future<void> writeTaskDefinition(TaskDefinition taskDefintion) async {
  final settings = await readSettings();
  final newSettings = settings.copyWith(taskDefinition: taskDefintion);
  await writeSettings(newSettings);
}

Future<void> deleteSettings() async {
  final file = await _settingsFile;
  await file.delete();
}
