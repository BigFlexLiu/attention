import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_definition.freezed.dart';
part 'task_definition.g.dart';

@freezed
abstract class TaskDefinition with _$TaskDefinition {
  const factory TaskDefinition({
    required bool defineSteps,
    required bool defineProblems,
    required bool defineReflect,
    required bool definePromise,
  }) = _TaskDefinition;

  factory TaskDefinition.fromJson(Map<String, dynamic> json) =>
      _$TaskDefinitionFromJson(json);
}
