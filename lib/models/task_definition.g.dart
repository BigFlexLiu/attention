// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskDefinitionImpl _$$TaskDefinitionImplFromJson(Map<String, dynamic> json) =>
    _$TaskDefinitionImpl(
      defineSteps: json['defineSteps'] as bool,
      defineProblems: json['defineProblems'] as bool,
      defineReflect: json['defineReflect'] as bool,
      definePromise: json['definePromise'] as bool,
    );

Map<String, dynamic> _$$TaskDefinitionImplToJson(
        _$TaskDefinitionImpl instance) =>
    <String, dynamic>{
      'defineSteps': instance.defineSteps,
      'defineProblems': instance.defineProblems,
      'defineReflect': instance.defineReflect,
      'definePromise': instance.definePromise,
    };
