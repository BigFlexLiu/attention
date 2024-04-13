// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoNoteImpl _$$TodoNoteImplFromJson(Map<String, dynamic> json) =>
    _$TodoNoteImpl(
      id: json['id'] as String?,
      title: json['title'] as String,
      children: (json['children'] as List<dynamic>)
          .map((e) => TodoNote.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      isDone: json['isDone'] as bool,
    );

Map<String, dynamic> _$$TodoNoteImplToJson(_$TodoNoteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'children': instance.children,
      'createdAt': instance.createdAt?.toIso8601String(),
      'isDone': instance.isDone,
    };
