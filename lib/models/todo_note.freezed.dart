// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TodoNote _$TodoNoteFromJson(Map<String, dynamic> json) {
  return _TodoNote.fromJson(json);
}

/// @nodoc
mixin _$TodoNote {
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<TodoNote> get children => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get autoDeleteAt => throw _privateConstructorUsedError;
  bool get isDone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoNoteCopyWith<TodoNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoNoteCopyWith<$Res> {
  factory $TodoNoteCopyWith(TodoNote value, $Res Function(TodoNote) then) =
      _$TodoNoteCopyWithImpl<$Res, TodoNote>;
  @useResult
  $Res call(
      {String? id,
      String title,
      List<TodoNote> children,
      DateTime? createdAt,
      DateTime? autoDeleteAt,
      bool isDone});
}

/// @nodoc
class _$TodoNoteCopyWithImpl<$Res, $Val extends TodoNote>
    implements $TodoNoteCopyWith<$Res> {
  _$TodoNoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? children = null,
    Object? createdAt = freezed,
    Object? autoDeleteAt = freezed,
    Object? isDone = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      children: null == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<TodoNote>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      autoDeleteAt: freezed == autoDeleteAt
          ? _value.autoDeleteAt
          : autoDeleteAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isDone: null == isDone
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodoNoteImplCopyWith<$Res>
    implements $TodoNoteCopyWith<$Res> {
  factory _$$TodoNoteImplCopyWith(
          _$TodoNoteImpl value, $Res Function(_$TodoNoteImpl) then) =
      __$$TodoNoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String title,
      List<TodoNote> children,
      DateTime? createdAt,
      DateTime? autoDeleteAt,
      bool isDone});
}

/// @nodoc
class __$$TodoNoteImplCopyWithImpl<$Res>
    extends _$TodoNoteCopyWithImpl<$Res, _$TodoNoteImpl>
    implements _$$TodoNoteImplCopyWith<$Res> {
  __$$TodoNoteImplCopyWithImpl(
      _$TodoNoteImpl _value, $Res Function(_$TodoNoteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? children = null,
    Object? createdAt = freezed,
    Object? autoDeleteAt = freezed,
    Object? isDone = null,
  }) {
    return _then(_$TodoNoteImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<TodoNote>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      autoDeleteAt: freezed == autoDeleteAt
          ? _value.autoDeleteAt
          : autoDeleteAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isDone: null == isDone
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TodoNoteImpl with DiagnosticableTreeMixin implements _TodoNote {
  const _$TodoNoteImpl(
      {required this.id,
      required this.title,
      required final List<TodoNote> children,
      required this.createdAt,
      required this.autoDeleteAt,
      required this.isDone})
      : _children = children;

  factory _$TodoNoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoNoteImplFromJson(json);

  @override
  final String? id;
  @override
  final String title;
  final List<TodoNote> _children;
  @override
  List<TodoNote> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? autoDeleteAt;
  @override
  final bool isDone;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TodoNote(id: $id, title: $title, children: $children, createdAt: $createdAt, autoDeleteAt: $autoDeleteAt, isDone: $isDone)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TodoNote'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('children', children))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('autoDeleteAt', autoDeleteAt))
      ..add(DiagnosticsProperty('isDone', isDone));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoNoteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.autoDeleteAt, autoDeleteAt) ||
                other.autoDeleteAt == autoDeleteAt) &&
            (identical(other.isDone, isDone) || other.isDone == isDone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      const DeepCollectionEquality().hash(_children),
      createdAt,
      autoDeleteAt,
      isDone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoNoteImplCopyWith<_$TodoNoteImpl> get copyWith =>
      __$$TodoNoteImplCopyWithImpl<_$TodoNoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoNoteImplToJson(
      this,
    );
  }
}

abstract class _TodoNote implements TodoNote {
  const factory _TodoNote(
      {required final String? id,
      required final String title,
      required final List<TodoNote> children,
      required final DateTime? createdAt,
      required final DateTime? autoDeleteAt,
      required final bool isDone}) = _$TodoNoteImpl;

  factory _TodoNote.fromJson(Map<String, dynamic> json) =
      _$TodoNoteImpl.fromJson;

  @override
  String? get id;
  @override
  String get title;
  @override
  List<TodoNote> get children;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get autoDeleteAt;
  @override
  bool get isDone;
  @override
  @JsonKey(ignore: true)
  _$$TodoNoteImplCopyWith<_$TodoNoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
