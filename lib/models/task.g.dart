// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      id: json['id'] as int,
      parentTask: json['parentTask'] == null
          ? null
          : Task.fromJson(json['parentTask'] as Map<String, dynamic>),
      title: json['title'] as String,
      duration: json['duration'] == null
          ? null
          : Duration(microseconds: json['duration'] as int),
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      steps: (json['steps'] as List<dynamic>)
          .map((e) => Substep.fromJson(e as Map<String, dynamic>))
          .toList(),
      personalImportance: json['personalImportance'] as String,
      problemSolutions: (json['problemSolutions'] as List<dynamic>)
          .map((e) => ProblemSolution.fromJson(e as Map<String, dynamic>))
          .toList(),
      reward: json['reward'] as String,
      completed: json['completed'] as bool,
      ended: json['ended'] as bool,
      reflectionQuestion: json['reflectionQuestion'] as String,
      reflectionAnswer: json['reflectionAnswer'] as String,
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parentTask': instance.parentTask,
      'title': instance.title,
      'duration': instance.duration?.inMicroseconds,
      'startTime': instance.startTime?.toIso8601String(),
      'steps': instance.steps,
      'personalImportance': instance.personalImportance,
      'problemSolutions': instance.problemSolutions,
      'reward': instance.reward,
      'completed': instance.completed,
      'ended': instance.ended,
      'reflectionQuestion': instance.reflectionQuestion,
      'reflectionAnswer': instance.reflectionAnswer,
    };
