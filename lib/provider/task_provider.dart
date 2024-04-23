import 'package:attention/io/tasks_io.dart';
import 'package:flutter/cupertino.dart';

import '../models/problem_solution.dart';
import '../models/substep.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  Task _task = Task.defaultsetup();

  Task get task => _task;

  Future<void> init() async {
    final task = await readCurrentTask();
    if (task != null) {
      _task = task;
      saveChange();
    }
    notifyListeners();
  }

  Future<void> newTask() async {
    int id = await readTaskIdCounter();
    _task = Task.defaultsetup();
    setTaskId(id);
  }

  void setTask(Task task) {
    _task = task;
    saveChange();
  }

  void resetTask() {
    _task = _task.copyWith(startTime: null, completed: false, ended: false);
    saveChange();
  }

  void setTaskId(int id) {
    _task = _task.copyWith(id: id);
    saveChange();
  }

  void setTaskParentTask(Task? parentTask) {
    _task = _task.copyWith(parentTask: parentTask);
    saveChange();
  }

  void setTaskTitle(String title) {
    _task = _task.copyWith(title: title);
    saveChange();
  }

  void setTaskTime(Duration? duration) {
    _task = _task.copyWith(duration: duration);
    saveChange();
  }

  void setTaskStartTime(DateTime? startTime) {
    _task = _task.copyWith(startTime: startTime);
    saveChange();
  }

  void setTaskSteps(List<Substep> steps) {
    _task = _task.copyWith(steps: steps);
    saveChange();
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
    saveChange();
  }

  void setTaskProblemSolutions(List<ProblemSolution> problemSolutions) {
    _task = _task.copyWith(problemSolutions: problemSolutions);
    saveChange();
  }

  void addProblemSolution(ProblemSolution problemSolution) {
    _task = _task.copyWith(
        problemSolutions: _task.problemSolutions + [problemSolution]);
    saveChange();
  }

  void removeProblemSolution(ProblemSolution problemSolution) {
    List<ProblemSolution> problemSolutions = _task.problemSolutions.toList();
    problemSolutions.remove(problemSolution);
    _task = _task.copyWith(problemSolutions: problemSolutions);
    saveChange();
  }

  void updateProblemSolution(
      ProblemSolution oldProblemSolution, ProblemSolution newProblemSolution) {
    List<ProblemSolution> problemSolutions = _task.problemSolutions.toList();
    problemSolutions[problemSolutions.indexOf(oldProblemSolution)] =
        newProblemSolution;
    _task = _task.copyWith(problemSolutions: problemSolutions);
    saveChange();
  }

  void setTaskReward(String reward) {
    _task = _task.copyWith(reward: reward);
    saveChange();
  }

  void updateReflection(String question, String answer) {
    _task =
        _task.copyWith(reflectionQuestion: question, reflectionAnswer: answer);
    saveChange();
  }

  void complete() {
    _task = _task.copyWith(completed: true);
    saveChange();
  }

  Future<void> addTaskToHistory() async {
    await addAsPastTask(_task);
  }

  Future<void> endTask() async {
    _task = _task.copyWith(ended: true);
    incrementTaskIdCounter();
    await addTaskToHistory();
    saveChange();
  }

  void restartTask(parentTask) async {
    _task = _task.copyWith(
        id: await readTaskIdCounter(),
        parentTask: parentTask,
        ended: false,
        completed: false,
        startTime: DateTime.now());
    saveChange();
  }

  void saveChange() {
    writeCurrentTask(task);
    notifyListeners();
  }

  get is_all_steps_completed => _task.steps.every((step) => step.isCompleted);
}
