import 'package:attention/io/tasks_io.dart';
import 'package:attention/models/task.dart';
import 'package:flutter/material.dart';

class AllTasksProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> init() async {
    _tasks = await readPastTasks();
    save();
  }

  void addTask(Task task) {
    _tasks.add(task);
    save();
  }

  void removeTasks(List<Task> tasks) {
    Set<Task> taskSet = tasks.toSet();
    _tasks.removeWhere((element) => taskSet.contains(element));
    save();
  }

  void updateTask(Task task) {
    final index = _tasks.indexWhere((element) => element.id == task.id);
    _tasks[index] = task;
    save();
  }

  void save() async {
    await writePastTasks(_tasks);
    notifyListeners();
  }

  void reload() async {
    _tasks = await readPastTasks();
    notifyListeners();
  }
}
