import 'package:flutter/cupertino.dart';

import '../models/problem_solution.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  Task _tasks = Task.defaultsetup();

  Task get tasks => _tasks;

  void setTask(Task task) {
    _tasks = task;
    notifyListeners();
  }

  void setTaskTitle(String title) {
    _tasks = _tasks.copyWith(title: title);
    notifyListeners();
  }

  void setTaskTime(Duration? duration) {
    _tasks = _tasks.copyWith(duration: duration);
    notifyListeners();
  }

  void setTaskStartTime(DateTime? startTime) {
    _tasks = _tasks.copyWith(startTime: startTime);
    notifyListeners();
  }

  void setTaskSteps(List<String> steps) {
    _tasks = _tasks.copyWith(steps: steps);
    notifyListeners();
  }

  void setTaskPersonalImportance(String personalImportance) {
    _tasks = _tasks.copyWith(personalImportance: personalImportance);
    notifyListeners();
  }

  void setTaskProblemSolutions(List<ProblemSolution> problemSolutions) {
    _tasks = _tasks.copyWith(problemSolutions: problemSolutions);
    notifyListeners();
  }

  void setTaskReward(String reward) {
    _tasks = _tasks.copyWith(reward: reward);
    notifyListeners();
  }

  void setTaskCompleted(bool completed) {
    _tasks = _tasks.copyWith(completed: completed);
    notifyListeners();
  }
}
