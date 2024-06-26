// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Settings _$SettingsFromJson(Map<String, dynamic> json) {
  return _Settings.fromJson(json);
}

/// @nodoc
mixin _$Settings {
  TaskDefinition get taskDefinition => throw _privateConstructorUsedError;
  PainterTheme get painterTheme => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SettingsCopyWith<Settings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsCopyWith<$Res> {
  factory $SettingsCopyWith(Settings value, $Res Function(Settings) then) =
      _$SettingsCopyWithImpl<$Res, Settings>;
  @useResult
  $Res call({TaskDefinition taskDefinition, PainterTheme painterTheme});

  $TaskDefinitionCopyWith<$Res> get taskDefinition;
}

/// @nodoc
class _$SettingsCopyWithImpl<$Res, $Val extends Settings>
    implements $SettingsCopyWith<$Res> {
  _$SettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskDefinition = null,
    Object? painterTheme = null,
  }) {
    return _then(_value.copyWith(
      taskDefinition: null == taskDefinition
          ? _value.taskDefinition
          : taskDefinition // ignore: cast_nullable_to_non_nullable
              as TaskDefinition,
      painterTheme: null == painterTheme
          ? _value.painterTheme
          : painterTheme // ignore: cast_nullable_to_non_nullable
              as PainterTheme,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TaskDefinitionCopyWith<$Res> get taskDefinition {
    return $TaskDefinitionCopyWith<$Res>(_value.taskDefinition, (value) {
      return _then(_value.copyWith(taskDefinition: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SettingsImplCopyWith<$Res>
    implements $SettingsCopyWith<$Res> {
  factory _$$SettingsImplCopyWith(
          _$SettingsImpl value, $Res Function(_$SettingsImpl) then) =
      __$$SettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TaskDefinition taskDefinition, PainterTheme painterTheme});

  @override
  $TaskDefinitionCopyWith<$Res> get taskDefinition;
}

/// @nodoc
class __$$SettingsImplCopyWithImpl<$Res>
    extends _$SettingsCopyWithImpl<$Res, _$SettingsImpl>
    implements _$$SettingsImplCopyWith<$Res> {
  __$$SettingsImplCopyWithImpl(
      _$SettingsImpl _value, $Res Function(_$SettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskDefinition = null,
    Object? painterTheme = null,
  }) {
    return _then(_$SettingsImpl(
      taskDefinition: null == taskDefinition
          ? _value.taskDefinition
          : taskDefinition // ignore: cast_nullable_to_non_nullable
              as TaskDefinition,
      painterTheme: null == painterTheme
          ? _value.painterTheme
          : painterTheme // ignore: cast_nullable_to_non_nullable
              as PainterTheme,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SettingsImpl implements _Settings {
  const _$SettingsImpl(
      {required this.taskDefinition, required this.painterTheme});

  factory _$SettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingsImplFromJson(json);

  @override
  final TaskDefinition taskDefinition;
  @override
  final PainterTheme painterTheme;

  @override
  String toString() {
    return 'Settings(taskDefinition: $taskDefinition, painterTheme: $painterTheme)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsImpl &&
            (identical(other.taskDefinition, taskDefinition) ||
                other.taskDefinition == taskDefinition) &&
            (identical(other.painterTheme, painterTheme) ||
                other.painterTheme == painterTheme));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, taskDefinition, painterTheme);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsImplCopyWith<_$SettingsImpl> get copyWith =>
      __$$SettingsImplCopyWithImpl<_$SettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingsImplToJson(
      this,
    );
  }
}

abstract class _Settings implements Settings {
  const factory _Settings(
      {required final TaskDefinition taskDefinition,
      required final PainterTheme painterTheme}) = _$SettingsImpl;

  factory _Settings.fromJson(Map<String, dynamic> json) =
      _$SettingsImpl.fromJson;

  @override
  TaskDefinition get taskDefinition;
  @override
  PainterTheme get painterTheme;
  @override
  @JsonKey(ignore: true)
  _$$SettingsImplCopyWith<_$SettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
