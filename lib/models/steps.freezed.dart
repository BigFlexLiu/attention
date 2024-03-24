// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'steps.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Steps _$StepsFromJson(Map<String, dynamic> json) {
  return _Steps.fromJson(json);
}

/// @nodoc
mixin _$Steps {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StepsCopyWith<Steps> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StepsCopyWith<$Res> {
  factory $StepsCopyWith(Steps value, $Res Function(Steps) then) =
      _$StepsCopyWithImpl<$Res, Steps>;
  @useResult
  $Res call({String title, String description});
}

/// @nodoc
class _$StepsCopyWithImpl<$Res, $Val extends Steps>
    implements $StepsCopyWith<$Res> {
  _$StepsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StepsImplCopyWith<$Res> implements $StepsCopyWith<$Res> {
  factory _$$StepsImplCopyWith(
          _$StepsImpl value, $Res Function(_$StepsImpl) then) =
      __$$StepsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String description});
}

/// @nodoc
class __$$StepsImplCopyWithImpl<$Res>
    extends _$StepsCopyWithImpl<$Res, _$StepsImpl>
    implements _$$StepsImplCopyWith<$Res> {
  __$$StepsImplCopyWithImpl(
      _$StepsImpl _value, $Res Function(_$StepsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
  }) {
    return _then(_$StepsImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StepsImpl with DiagnosticableTreeMixin implements _Steps {
  const _$StepsImpl({required this.title, required this.description});

  factory _$StepsImpl.fromJson(Map<String, dynamic> json) =>
      _$$StepsImplFromJson(json);

  @override
  final String title;
  @override
  final String description;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Steps(title: $title, description: $description)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Steps'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StepsImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StepsImplCopyWith<_$StepsImpl> get copyWith =>
      __$$StepsImplCopyWithImpl<_$StepsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StepsImplToJson(
      this,
    );
  }
}

abstract class _Steps implements Steps {
  const factory _Steps(
      {required final String title,
      required final String description}) = _$StepsImpl;

  factory _Steps.fromJson(Map<String, dynamic> json) = _$StepsImpl.fromJson;

  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$StepsImplCopyWith<_$StepsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
