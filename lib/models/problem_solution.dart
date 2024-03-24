import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'problem_solution.freezed.dart';
part 'problem_solution.g.dart';

@freezed
abstract class ProblemSolution with _$ProblemSolution {
  const factory ProblemSolution({
    required String problem,
    required String solution,
  }) = _ProblemSolution;

  factory ProblemSolution.fromJson(Map<String, dynamic> json) =>
      _$ProblemSolutionFromJson(json);
}
