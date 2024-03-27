import 'package:attention/models/problem_solution.dart';
import 'package:attention/models/substep.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
abstract class Task with _$Task {
  const factory Task({
    required String title,
    required Duration? duration,
    required DateTime? startTime,
    required List<Substep> steps,
    required String personalImportance,
    required List<ProblemSolution> problemSolutions,
    required String reward,
    required bool completed,
    required String Reflection,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  factory Task.defaultsetup() => const Task(
        title: "",
        duration: null,
        startTime: null,
        steps: [],
        personalImportance: "",
        problemSolutions: [],
        reward: "",
        completed: false,
        Reflection: "",
      );

  factory Task.testsetup() => Task(
        title:
            "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        duration: const Duration(minutes: 30),
        startTime: DateTime.now(),
        steps: [
          const Substep(title: "Test Step 1", isCompleted: false),
          const Substep(title: "Test Step 2", isCompleted: false),
          const Substep(title: "Test Step 3", isCompleted: false),
        ],
        personalImportance: "High",
        problemSolutions: [
          const ProblemSolution(problem: "Test Problem", solution: "Test Solution"),
        ],
        reward: "Test Reward",
        completed: false,
        Reflection: "I learned to sipnut",
      );
}
