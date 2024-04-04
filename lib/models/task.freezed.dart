// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Task _$TaskFromJson(Map<String, dynamic> json) {
  return _Task.fromJson(json);
}

/// @nodoc
mixin _$Task {
  int get id => throw _privateConstructorUsedError;
  int? get parentId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  Duration? get duration => throw _privateConstructorUsedError;
  DateTime? get startTime => throw _privateConstructorUsedError;
  List<Substep> get steps => throw _privateConstructorUsedError;
  String get personalImportance => throw _privateConstructorUsedError;
  List<ProblemSolution> get problemSolutions =>
      throw _privateConstructorUsedError;
  String get reward => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;
  bool get ended => throw _privateConstructorUsedError;
  String get reflectionQuestion => throw _privateConstructorUsedError;
  String get reflectionAnswer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res, Task>;
  @useResult
  $Res call(
      {int id,
      int? parentId,
      String title,
      Duration? duration,
      DateTime? startTime,
      List<Substep> steps,
      String personalImportance,
      List<ProblemSolution> problemSolutions,
      String reward,
      bool completed,
      bool ended,
      String reflectionQuestion,
      String reflectionAnswer});
}

/// @nodoc
class _$TaskCopyWithImpl<$Res, $Val extends Task>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? parentId = freezed,
    Object? title = null,
    Object? duration = freezed,
    Object? startTime = freezed,
    Object? steps = null,
    Object? personalImportance = null,
    Object? problemSolutions = null,
    Object? reward = null,
    Object? completed = null,
    Object? ended = null,
    Object? reflectionQuestion = null,
    Object? reflectionAnswer = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<Substep>,
      personalImportance: null == personalImportance
          ? _value.personalImportance
          : personalImportance // ignore: cast_nullable_to_non_nullable
              as String,
      problemSolutions: null == problemSolutions
          ? _value.problemSolutions
          : problemSolutions // ignore: cast_nullable_to_non_nullable
              as List<ProblemSolution>,
      reward: null == reward
          ? _value.reward
          : reward // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      ended: null == ended
          ? _value.ended
          : ended // ignore: cast_nullable_to_non_nullable
              as bool,
      reflectionQuestion: null == reflectionQuestion
          ? _value.reflectionQuestion
          : reflectionQuestion // ignore: cast_nullable_to_non_nullable
              as String,
      reflectionAnswer: null == reflectionAnswer
          ? _value.reflectionAnswer
          : reflectionAnswer // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskImplCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$TaskImplCopyWith(
          _$TaskImpl value, $Res Function(_$TaskImpl) then) =
      __$$TaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int? parentId,
      String title,
      Duration? duration,
      DateTime? startTime,
      List<Substep> steps,
      String personalImportance,
      List<ProblemSolution> problemSolutions,
      String reward,
      bool completed,
      bool ended,
      String reflectionQuestion,
      String reflectionAnswer});
}

/// @nodoc
class __$$TaskImplCopyWithImpl<$Res>
    extends _$TaskCopyWithImpl<$Res, _$TaskImpl>
    implements _$$TaskImplCopyWith<$Res> {
  __$$TaskImplCopyWithImpl(_$TaskImpl _value, $Res Function(_$TaskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? parentId = freezed,
    Object? title = null,
    Object? duration = freezed,
    Object? startTime = freezed,
    Object? steps = null,
    Object? personalImportance = null,
    Object? problemSolutions = null,
    Object? reward = null,
    Object? completed = null,
    Object? ended = null,
    Object? reflectionQuestion = null,
    Object? reflectionAnswer = null,
  }) {
    return _then(_$TaskImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      steps: null == steps
          ? _value._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<Substep>,
      personalImportance: null == personalImportance
          ? _value.personalImportance
          : personalImportance // ignore: cast_nullable_to_non_nullable
              as String,
      problemSolutions: null == problemSolutions
          ? _value._problemSolutions
          : problemSolutions // ignore: cast_nullable_to_non_nullable
              as List<ProblemSolution>,
      reward: null == reward
          ? _value.reward
          : reward // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      ended: null == ended
          ? _value.ended
          : ended // ignore: cast_nullable_to_non_nullable
              as bool,
      reflectionQuestion: null == reflectionQuestion
          ? _value.reflectionQuestion
          : reflectionQuestion // ignore: cast_nullable_to_non_nullable
              as String,
      reflectionAnswer: null == reflectionAnswer
          ? _value.reflectionAnswer
          : reflectionAnswer // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskImpl with DiagnosticableTreeMixin implements _Task {
  const _$TaskImpl(
      {required this.id,
      required this.parentId,
      required this.title,
      required this.duration,
      required this.startTime,
      required final List<Substep> steps,
      required this.personalImportance,
      required final List<ProblemSolution> problemSolutions,
      required this.reward,
      required this.completed,
      required this.ended,
      required this.reflectionQuestion,
      required this.reflectionAnswer})
      : _steps = steps,
        _problemSolutions = problemSolutions;

  factory _$TaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskImplFromJson(json);

  @override
  final int id;
  @override
  final int? parentId;
  @override
  final String title;
  @override
  final Duration? duration;
  @override
  final DateTime? startTime;
  final List<Substep> _steps;
  @override
  List<Substep> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  @override
  final String personalImportance;
  final List<ProblemSolution> _problemSolutions;
  @override
  List<ProblemSolution> get problemSolutions {
    if (_problemSolutions is EqualUnmodifiableListView)
      return _problemSolutions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_problemSolutions);
  }

  @override
  final String reward;
  @override
  final bool completed;
  @override
  final bool ended;
  @override
  final String reflectionQuestion;
  @override
  final String reflectionAnswer;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Task(id: $id, parentId: $parentId, title: $title, duration: $duration, startTime: $startTime, steps: $steps, personalImportance: $personalImportance, problemSolutions: $problemSolutions, reward: $reward, completed: $completed, ended: $ended, reflectionQuestion: $reflectionQuestion, reflectionAnswer: $reflectionAnswer)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Task'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('parentId', parentId))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('duration', duration))
      ..add(DiagnosticsProperty('startTime', startTime))
      ..add(DiagnosticsProperty('steps', steps))
      ..add(DiagnosticsProperty('personalImportance', personalImportance))
      ..add(DiagnosticsProperty('problemSolutions', problemSolutions))
      ..add(DiagnosticsProperty('reward', reward))
      ..add(DiagnosticsProperty('completed', completed))
      ..add(DiagnosticsProperty('ended', ended))
      ..add(DiagnosticsProperty('reflectionQuestion', reflectionQuestion))
      ..add(DiagnosticsProperty('reflectionAnswer', reflectionAnswer));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            (identical(other.personalImportance, personalImportance) ||
                other.personalImportance == personalImportance) &&
            const DeepCollectionEquality()
                .equals(other._problemSolutions, _problemSolutions) &&
            (identical(other.reward, reward) || other.reward == reward) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.ended, ended) || other.ended == ended) &&
            (identical(other.reflectionQuestion, reflectionQuestion) ||
                other.reflectionQuestion == reflectionQuestion) &&
            (identical(other.reflectionAnswer, reflectionAnswer) ||
                other.reflectionAnswer == reflectionAnswer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      parentId,
      title,
      duration,
      startTime,
      const DeepCollectionEquality().hash(_steps),
      personalImportance,
      const DeepCollectionEquality().hash(_problemSolutions),
      reward,
      completed,
      ended,
      reflectionQuestion,
      reflectionAnswer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      __$$TaskImplCopyWithImpl<_$TaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskImplToJson(
      this,
    );
  }
}

abstract class _Task implements Task {
  const factory _Task(
      {required final int id,
      required final int? parentId,
      required final String title,
      required final Duration? duration,
      required final DateTime? startTime,
      required final List<Substep> steps,
      required final String personalImportance,
      required final List<ProblemSolution> problemSolutions,
      required final String reward,
      required final bool completed,
      required final bool ended,
      required final String reflectionQuestion,
      required final String reflectionAnswer}) = _$TaskImpl;

  factory _Task.fromJson(Map<String, dynamic> json) = _$TaskImpl.fromJson;

  @override
  int get id;
  @override
  int? get parentId;
  @override
  String get title;
  @override
  Duration? get duration;
  @override
  DateTime? get startTime;
  @override
  List<Substep> get steps;
  @override
  String get personalImportance;
  @override
  List<ProblemSolution> get problemSolutions;
  @override
  String get reward;
  @override
  bool get completed;
  @override
  bool get ended;
  @override
  String get reflectionQuestion;
  @override
  String get reflectionAnswer;
  @override
  @JsonKey(ignore: true)
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
