import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/task.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _currentTaskFile async {
  final path = await _localPath;
  return File('$path/current_task.json');
}

Future<File> get _pastTasksFile async {
  final path = await _localPath;
  return File('$path/past_tasks.json');
}

Future<File> writeCurrentTask(Task task) async {
  final file = await _currentTaskFile;

  return file.writeAsString(jsonEncode(task));
}

Future<Task?> readCurrentTask() async {
  try {
    final file = await _currentTaskFile;

    if (!await file.exists()) {
      // Handle the case where the file does not exist or return a default value
      return null;
    }

    final String contents = await file.readAsString();

    return Task.fromJson(jsonDecode(contents));
  } catch (e) {
    return null;
  }
}

Future<List<Task>> readPastTasks() async {
  try {
    final file = await _pastTasksFile;

    if (!await file.exists()) {
      // Handle the case where the file does not exist or return a default value
      return [];
    }

    final List<dynamic> contents = json.decode(await file.readAsString());
    final List<Task> tasks = contents
        .map((dynamic item) => Task.fromJson(item as Map<String, dynamic>))
        .toList();

    return tasks;
  } catch (e) {
    return [];
  }
}

Future<void> addAsPastTask(Task task) async {
  final file = await _pastTasksFile;
  List<Task> allTasks = await readPastTasks();
  allTasks.add(task);

  file.writeAsString(jsonEncode(allTasks));
}

/*
  ID counter
*/
Future<int> readTaskIdCounter() async {
  try {
    final path = await _localPath;
    final file = File('$path/task_id_counter.json');

    if (!await file.exists()) {
      return 0;
    }

    final String contents = await file.readAsString();

    return int.parse(contents);
  } catch (e) {
    return 0;
  }
}

Future<void> incrementTaskIdCounter() async {
  final path = await _localPath;
  final file = File('$path/task_id_counter.json');

  if (!await file.exists()) {
    return;
  }
  final String contents = await file.readAsString();

  int id = int.parse(contents) + 1;

  file.writeAsString(id.toString());
}

/*
  Testing
*/
Future<File> clearPastTasks() async {
  final file = await _pastTasksFile;

  return file.writeAsString(jsonEncode([]));
}

Future<File> deleteCurrentTask() async {
  final file = await _currentTaskFile;

  return file.writeAsString(jsonEncode(""));
}
