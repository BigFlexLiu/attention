// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsImpl _$$SettingsImplFromJson(Map<String, dynamic> json) =>
    _$SettingsImpl(
      taskDefinition: TaskDefinition.fromJson(
          json['taskDefinition'] as Map<String, dynamic>),
      painterTheme: $enumDecode(_$PainterThemeEnumMap, json['painterTheme']),
    );

Map<String, dynamic> _$$SettingsImplToJson(_$SettingsImpl instance) =>
    <String, dynamic>{
      'taskDefinition': instance.taskDefinition,
      'painterTheme': _$PainterThemeEnumMap[instance.painterTheme]!,
    };

const _$PainterThemeEnumMap = {
  PainterTheme.none: 'none',
  PainterTheme.circle: 'circle',
  PainterTheme.ripple: 'ripple',
  PainterTheme.bubble: 'bubble',
};
