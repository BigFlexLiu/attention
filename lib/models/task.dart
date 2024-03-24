import 'package:attention/models/problem_solution.dart';
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
    required List<String> steps,
    required String personalImportance,
    required List<ProblemSolution> problemSolutions,
    required String reward,
    required bool completed,
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
      );
}
