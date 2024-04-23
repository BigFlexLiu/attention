// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_definition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskDefinition _$TaskDefinitionFromJson(Map<String, dynamic> json) {
  return _TaskDefinition.fromJson(json);
}

/// @nodoc
mixin _$TaskDefinition {
  bool get defineSteps => throw _privateConstructorUsedError;
  bool get defineProblems => throw _privateConstructorUsedError;
  bool get defineReflect => throw _privateConstructorUsedError;
  bool get definePromise => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskDefinitionCopyWith<TaskDefinition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskDefinitionCopyWith<$Res> {
  factory $TaskDefinitionCopyWith(
          TaskDefinition value, $Res Function(TaskDefinition) then) =
      _$TaskDefinitionCopyWithImpl<$Res, TaskDefinition>;
  @useResult
  $Res call(
      {bool defineSteps,
      bool defineProblems,
      bool defineReflect,
      bool definePromise});
}

/// @nodoc
class _$TaskDefinitionCopyWithImpl<$Res, $Val extends TaskDefinition>
    implements $TaskDefinitionCopyWith<$Res> {
  _$TaskDefinitionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defineSteps = null,
    Object? defineProblems = null,
    Object? defineReflect = null,
    Object? definePromise = null,
  }) {
    return _then(_value.copyWith(
      defineSteps: null == defineSteps
          ? _value.defineSteps
          : defineSteps // ignore: cast_nullable_to_non_nullable
              as bool,
      defineProblems: null == defineProblems
          ? _value.defineProblems
          : defineProblems // ignore: cast_nullable_to_non_nullable
              as bool,
      defineReflect: null == defineReflect
          ? _value.defineReflect
          : defineReflect // ignore: cast_nullable_to_non_nullable
              as bool,
      definePromise: null == definePromise
          ? _value.definePromise
          : definePromise // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskDefinitionImplCopyWith<$Res>
    implements $TaskDefinitionCopyWith<$Res> {
  factory _$$TaskDefinitionImplCopyWith(_$TaskDefinitionImpl value,
          $Res Function(_$TaskDefinitionImpl) then) =
      __$$TaskDefinitionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool defineSteps,
      bool defineProblems,
      bool defineReflect,
      bool definePromise});
}

/// @nodoc
class __$$TaskDefinitionImplCopyWithImpl<$Res>
    extends _$TaskDefinitionCopyWithImpl<$Res, _$TaskDefinitionImpl>
    implements _$$TaskDefinitionImplCopyWith<$Res> {
  __$$TaskDefinitionImplCopyWithImpl(
      _$TaskDefinitionImpl _value, $Res Function(_$TaskDefinitionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defineSteps = null,
    Object? defineProblems = null,
    Object? defineReflect = null,
    Object? definePromise = null,
  }) {
    return _then(_$TaskDefinitionImpl(
      defineSteps: null == defineSteps
          ? _value.defineSteps
          : defineSteps // ignore: cast_nullable_to_non_nullable
              as bool,
      defineProblems: null == defineProblems
          ? _value.defineProblems
          : defineProblems // ignore: cast_nullable_to_non_nullable
              as bool,
      defineReflect: null == defineReflect
          ? _value.defineReflect
          : defineReflect // ignore: cast_nullable_to_non_nullable
              as bool,
      definePromise: null == definePromise
          ? _value.definePromise
          : definePromise // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskDefinitionImpl implements _TaskDefinition {
  const _$TaskDefinitionImpl(
      {required this.defineSteps,
      required this.defineProblems,
      required this.defineReflect,
      required this.definePromise});

  factory _$TaskDefinitionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskDefinitionImplFromJson(json);

  @override
  final bool defineSteps;
  @override
  final bool defineProblems;
  @override
  final bool defineReflect;
  @override
  final bool definePromise;

  @override
  String toString() {
    return 'TaskDefinition(defineSteps: $defineSteps, defineProblems: $defineProblems, defineReflect: $defineReflect, definePromise: $definePromise)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskDefinitionImpl &&
            (identical(other.defineSteps, defineSteps) ||
                other.defineSteps == defineSteps) &&
            (identical(other.defineProblems, defineProblems) ||
                other.defineProblems == defineProblems) &&
            (identical(other.defineReflect, defineReflect) ||
                other.defineReflect == defineReflect) &&
            (identical(other.definePromise, definePromise) ||
                other.definePromise == definePromise));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, defineSteps, defineProblems, defineReflect, definePromise);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskDefinitionImplCopyWith<_$TaskDefinitionImpl> get copyWith =>
      __$$TaskDefinitionImplCopyWithImpl<_$TaskDefinitionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskDefinitionImplToJson(
      this,
    );
  }
}

abstract class _TaskDefinition implements TaskDefinition {
  const factory _TaskDefinition(
      {required final bool defineSteps,
      required final bool defineProblems,
      required final bool defineReflect,
      required final bool definePromise}) = _$TaskDefinitionImpl;

  factory _TaskDefinition.fromJson(Map<String, dynamic> json) =
      _$TaskDefinitionImpl.fromJson;

  @override
  bool get defineSteps;
  @override
  bool get defineProblems;
  @override
  bool get defineReflect;
  @override
  bool get definePromise;
  @override
  @JsonKey(ignore: true)
  _$$TaskDefinitionImplCopyWith<_$TaskDefinitionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
