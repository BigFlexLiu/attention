// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SimpleNoteImpl _$$SimpleNoteImplFromJson(Map<String, dynamic> json) =>
    _$SimpleNoteImpl(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      autoDeleteAt: json['autoDeleteAt'] == null
          ? null
          : DateTime.parse(json['autoDeleteAt'] as String),
    );

Map<String, dynamic> _$$SimpleNoteImplToJson(_$SimpleNoteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'autoDeleteAt': instance.autoDeleteAt?.toIso8601String(),
    };
