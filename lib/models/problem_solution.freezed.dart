// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'problem_solution.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProblemSolution _$ProblemSolutionFromJson(Map<String, dynamic> json) {
  return _ProblemSolution.fromJson(json);
}

/// @nodoc
mixin _$ProblemSolution {
  String get problem => throw _privateConstructorUsedError;
  String get solution => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProblemSolutionCopyWith<ProblemSolution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProblemSolutionCopyWith<$Res> {
  factory $ProblemSolutionCopyWith(
          ProblemSolution value, $Res Function(ProblemSolution) then) =
      _$ProblemSolutionCopyWithImpl<$Res, ProblemSolution>;
  @useResult
  $Res call({String problem, String solution});
}

/// @nodoc
class _$ProblemSolutionCopyWithImpl<$Res, $Val extends ProblemSolution>
    implements $ProblemSolutionCopyWith<$Res> {
  _$ProblemSolutionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? problem = null,
    Object? solution = null,
  }) {
    return _then(_value.copyWith(
      problem: null == problem
          ? _value.problem
          : problem // ignore: cast_nullable_to_non_nullable
              as String,
      solution: null == solution
          ? _value.solution
          : solution // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProblemSolutionImplCopyWith<$Res>
    implements $ProblemSolutionCopyWith<$Res> {
  factory _$$ProblemSolutionImplCopyWith(_$ProblemSolutionImpl value,
          $Res Function(_$ProblemSolutionImpl) then) =
      __$$ProblemSolutionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String problem, String solution});
}

/// @nodoc
class __$$ProblemSolutionImplCopyWithImpl<$Res>
    extends _$ProblemSolutionCopyWithImpl<$Res, _$ProblemSolutionImpl>
    implements _$$ProblemSolutionImplCopyWith<$Res> {
  __$$ProblemSolutionImplCopyWithImpl(
      _$ProblemSolutionImpl _value, $Res Function(_$ProblemSolutionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? problem = null,
    Object? solution = null,
  }) {
    return _then(_$ProblemSolutionImpl(
      problem: null == problem
          ? _value.problem
          : problem // ignore: cast_nullable_to_non_nullable
              as String,
      solution: null == solution
          ? _value.solution
          : solution // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProblemSolutionImpl
    with DiagnosticableTreeMixin
    implements _ProblemSolution {
  const _$ProblemSolutionImpl({required this.problem, required this.solution});

  factory _$ProblemSolutionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProblemSolutionImplFromJson(json);

  @override
  final String problem;
  @override
  final String solution;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProblemSolution(problem: $problem, solution: $solution)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProblemSolution'))
      ..add(DiagnosticsProperty('problem', problem))
      ..add(DiagnosticsProperty('solution', solution));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProblemSolutionImpl &&
            (identical(other.problem, problem) || other.problem == problem) &&
            (identical(other.solution, solution) ||
                other.solution == solution));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, problem, solution);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProblemSolutionImplCopyWith<_$ProblemSolutionImpl> get copyWith =>
      __$$ProblemSolutionImplCopyWithImpl<_$ProblemSolutionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProblemSolutionImplToJson(
      this,
    );
  }
}

abstract class _ProblemSolution implements ProblemSolution {
  const factory _ProblemSolution(
      {required final String problem,
      required final String solution}) = _$ProblemSolutionImpl;

  factory _ProblemSolution.fromJson(Map<String, dynamic> json) =
      _$ProblemSolutionImpl.fromJson;

  @override
  String get problem;
  @override
  String get solution;
  @override
  @JsonKey(ignore: true)
  _$$ProblemSolutionImplCopyWith<_$ProblemSolutionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
