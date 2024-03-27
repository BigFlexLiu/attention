// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'substep.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Substep _$SubstepFromJson(Map<String, dynamic> json) {
  return _Substep.fromJson(json);
}

/// @nodoc
mixin _$Substep {
  String get title => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubstepCopyWith<Substep> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubstepCopyWith<$Res> {
  factory $SubstepCopyWith(Substep value, $Res Function(Substep) then) =
      _$SubstepCopyWithImpl<$Res, Substep>;
  @useResult
  $Res call({String title, bool isCompleted});
}

/// @nodoc
class _$SubstepCopyWithImpl<$Res, $Val extends Substep>
    implements $SubstepCopyWith<$Res> {
  _$SubstepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? isCompleted = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubstepImplCopyWith<$Res> implements $SubstepCopyWith<$Res> {
  factory _$$SubstepImplCopyWith(
          _$SubstepImpl value, $Res Function(_$SubstepImpl) then) =
      __$$SubstepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, bool isCompleted});
}

/// @nodoc
class __$$SubstepImplCopyWithImpl<$Res>
    extends _$SubstepCopyWithImpl<$Res, _$SubstepImpl>
    implements _$$SubstepImplCopyWith<$Res> {
  __$$SubstepImplCopyWithImpl(
      _$SubstepImpl _value, $Res Function(_$SubstepImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? isCompleted = null,
  }) {
    return _then(_$SubstepImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubstepImpl with DiagnosticableTreeMixin implements _Substep {
  const _$SubstepImpl({required this.title, required this.isCompleted});

  factory _$SubstepImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubstepImplFromJson(json);

  @override
  final String title;
  @override
  final bool isCompleted;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Substep(title: $title, isCompleted: $isCompleted)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Substep'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('isCompleted', isCompleted));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubstepImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, isCompleted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubstepImplCopyWith<_$SubstepImpl> get copyWith =>
      __$$SubstepImplCopyWithImpl<_$SubstepImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubstepImplToJson(
      this,
    );
  }
}

abstract class _Substep implements Substep {
  const factory _Substep(
      {required final String title,
      required final bool isCompleted}) = _$SubstepImpl;

  factory _Substep.fromJson(Map<String, dynamic> json) = _$SubstepImpl.fromJson;

  @override
  String get title;
  @override
  bool get isCompleted;
  @override
  @JsonKey(ignore: true)
  _$$SubstepImplCopyWith<_$SubstepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
