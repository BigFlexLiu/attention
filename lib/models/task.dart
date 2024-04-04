import 'package:attention/models/problem_solution.dart';
import 'package:attention/models/substep.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
abstract class Task with _$Task {
  const factory Task({
    required int id,
    required int? parentId,
    required String title,
    required Duration? duration,
    required DateTime? startTime,
    required List<Substep> steps,
    required String personalImportance,
    required List<ProblemSolution> problemSolutions,
    required String reward,
    required bool completed,
    required bool ended,
    required String reflectionQuestion,
    required String reflectionAnswer,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  factory Task.defaultsetup() => const Task(
        id: 0,
        parentId: null,
        title: "",
        duration: Duration(minutes: 25),
        startTime: null,
        steps: [],
        personalImportance: "",
        problemSolutions: [],
        reward: "",
        completed: false,
        ended: false,
        reflectionQuestion: "",
        reflectionAnswer: "",
      );

  factory Task.testsetup() => Task(
        id: 0,
        parentId: null,
        title: "Sample Task",
        duration: const Duration(minutes: 30),
        startTime: DateTime.now(),
        steps: [
          const Substep(title: "Test Step 1", isCompleted: false),
          const Substep(title: "Test Step 2", isCompleted: false),
          const Substep(title: "Test Step 3", isCompleted: false),
        ],
        personalImportance: "High",
        problemSolutions: [
          const ProblemSolution(
              problem: "Test Problem", solution: "Test Solution"),
        ],
        reward: "Test Reward",
        completed: false,
        ended: false,
        reflectionQuestion: "What did you learn?",
        reflectionAnswer: "I learned to sipnut",
      );
}
