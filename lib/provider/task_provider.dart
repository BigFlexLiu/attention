import 'package:flutter/cupertino.dart';

import '../models/problem_solution.dart';
import '../models/substep.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  Task _task = Task.testsetup();

  Task get task => _task;

  void setTask(Task task) {
    _task = task;
    notifyListeners();
  }

  void setTaskTitle(String title) {
    _task = _task.copyWith(title: title);
    notifyListeners();
  }

  void setTaskTime(Duration? duration) {
    _task = _task.copyWith(duration: duration);
    notifyListeners();
  }

  void setTaskStartTime(DateTime? startTime) {
    _task = _task.copyWith(startTime: startTime);
    notifyListeners();
  }

  void setTaskSteps(List<Substep> steps) {
    _task = _task.copyWith(steps: steps);
    notifyListeners();
  }

  void completeStep(Substep step) {
    final index = _task.steps.indexOf(step);
    final Substep newStep = step.copyWith(isCompleted: !step.isCompleted);
    final List<Substep> newSteps = List.from(_task.steps);
    newSteps[index] = newStep;

    setTaskSteps(newSteps);
  }

  void completeAllSteps() {
    final List<Substep> newSteps =
        _task.steps.map((step) => step.copyWith(isCompleted: true)).toList();

    setTaskSteps(newSteps);
  }

  void setTaskPersonalImportance(String personalImportance) {
    _task = _task.copyWith(personalImportance: personalImportance);
    notifyListeners();
  }

  void setTaskProblemSolutions(List<ProblemSolution> problemSolutions) {
    _task = _task.copyWith(problemSolutions: problemSolutions);
    notifyListeners();
  }

  void addProblemSolution(ProblemSolution problemSolution) {
    _task = _task.copyWith(
        problemSolutions: _task.problemSolutions + [problemSolution]);
    notifyListeners();
  }

  void removeProblemSolution(ProblemSolution problemSolution) {
    _task = _task.copyWith(
        problemSolutions: _task.problemSolutions..remove(problemSolution));
    notifyListeners();
  }

  void updateProblemSolution(
      ProblemSolution oldProblemSolution, ProblemSolution newProblemSolution) {
    List<ProblemSolution> problemSolutions = _task.problemSolutions.toList();
    problemSolutions[problemSolutions.indexOf(oldProblemSolution)] =
        newProblemSolution;
    _task = _task.copyWith(problemSolutions: problemSolutions);
    notifyListeners();
  }

  void setTaskReward(String reward) {
    _task = _task.copyWith(reward: reward);
    notifyListeners();
  }

  void setTaskCompleted(bool completed) {
    _task = _task.copyWith(completed: completed);
    notifyListeners();
  }
}
