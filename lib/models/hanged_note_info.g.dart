// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hanged_note_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HangedNoteInfoImpl _$$HangedNoteInfoImplFromJson(Map<String, dynamic> json) =>
    _$HangedNoteInfoImpl(
      id: json['id'] as int,
      hangedAt: DateTime.parse(json['hangedAt'] as String),
      hangUntil: DateTime.parse(json['hangUntil'] as String),
    );

Map<String, dynamic> _$$HangedNoteInfoImplToJson(
        _$HangedNoteInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hangedAt': instance.hangedAt.toIso8601String(),
      'hangUntil': instance.hangUntil.toIso8601String(),
    };
