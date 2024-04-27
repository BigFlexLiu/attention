// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simple_note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SimpleNote _$SimpleNoteFromJson(Map<String, dynamic> json) {
  return _SimpleNote.fromJson(json);
}

/// @nodoc
mixin _$SimpleNote {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get autoDeleteAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SimpleNoteCopyWith<SimpleNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimpleNoteCopyWith<$Res> {
  factory $SimpleNoteCopyWith(
          SimpleNote value, $Res Function(SimpleNote) then) =
      _$SimpleNoteCopyWithImpl<$Res, SimpleNote>;
  @useResult
  $Res call(
      {int id,
      String title,
      String content,
      DateTime createdAt,
      DateTime? autoDeleteAt});
}

/// @nodoc
class _$SimpleNoteCopyWithImpl<$Res, $Val extends SimpleNote>
    implements $SimpleNoteCopyWith<$Res> {
  _$SimpleNoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? createdAt = null,
    Object? autoDeleteAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      autoDeleteAt: freezed == autoDeleteAt
          ? _value.autoDeleteAt
          : autoDeleteAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SimpleNoteImplCopyWith<$Res>
    implements $SimpleNoteCopyWith<$Res> {
  factory _$$SimpleNoteImplCopyWith(
          _$SimpleNoteImpl value, $Res Function(_$SimpleNoteImpl) then) =
      __$$SimpleNoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String content,
      DateTime createdAt,
      DateTime? autoDeleteAt});
}

/// @nodoc
class __$$SimpleNoteImplCopyWithImpl<$Res>
    extends _$SimpleNoteCopyWithImpl<$Res, _$SimpleNoteImpl>
    implements _$$SimpleNoteImplCopyWith<$Res> {
  __$$SimpleNoteImplCopyWithImpl(
      _$SimpleNoteImpl _value, $Res Function(_$SimpleNoteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? createdAt = null,
    Object? autoDeleteAt = freezed,
  }) {
    return _then(_$SimpleNoteImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      autoDeleteAt: freezed == autoDeleteAt
          ? _value.autoDeleteAt
          : autoDeleteAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SimpleNoteImpl with DiagnosticableTreeMixin implements _SimpleNote {
  const _$SimpleNoteImpl(
      {required this.id,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.autoDeleteAt});

  factory _$SimpleNoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$SimpleNoteImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String content;
  @override
  final DateTime createdAt;
  @override
  final DateTime? autoDeleteAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SimpleNote(id: $id, title: $title, content: $content, createdAt: $createdAt, autoDeleteAt: $autoDeleteAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SimpleNote'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('autoDeleteAt', autoDeleteAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimpleNoteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.autoDeleteAt, autoDeleteAt) ||
                other.autoDeleteAt == autoDeleteAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, content, createdAt, autoDeleteAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SimpleNoteImplCopyWith<_$SimpleNoteImpl> get copyWith =>
      __$$SimpleNoteImplCopyWithImpl<_$SimpleNoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SimpleNoteImplToJson(
      this,
    );
  }
}

abstract class _SimpleNote implements SimpleNote {
  const factory _SimpleNote(
      {required final int id,
      required final String title,
      required final String content,
      required final DateTime createdAt,
      required final DateTime? autoDeleteAt}) = _$SimpleNoteImpl;

  factory _SimpleNote.fromJson(Map<String, dynamic> json) =
      _$SimpleNoteImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get content;
  @override
  DateTime get createdAt;
  @override
  DateTime? get autoDeleteAt;
  @override
  @JsonKey(ignore: true)
  _$$SimpleNoteImplCopyWith<_$SimpleNoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
