// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hanged_note_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HangedNoteInfo _$HangedNoteInfoFromJson(Map<String, dynamic> json) {
  return _HangedNoteInfo.fromJson(json);
}

/// @nodoc
mixin _$HangedNoteInfo {
  int get id => throw _privateConstructorUsedError;
  DateTime get hangedAt => throw _privateConstructorUsedError; // id: DateTime
  DateTime get hangUntil => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HangedNoteInfoCopyWith<HangedNoteInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HangedNoteInfoCopyWith<$Res> {
  factory $HangedNoteInfoCopyWith(
          HangedNoteInfo value, $Res Function(HangedNoteInfo) then) =
      _$HangedNoteInfoCopyWithImpl<$Res, HangedNoteInfo>;
  @useResult
  $Res call({int id, DateTime hangedAt, DateTime hangUntil});
}

/// @nodoc
class _$HangedNoteInfoCopyWithImpl<$Res, $Val extends HangedNoteInfo>
    implements $HangedNoteInfoCopyWith<$Res> {
  _$HangedNoteInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hangedAt = null,
    Object? hangUntil = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      hangedAt: null == hangedAt
          ? _value.hangedAt
          : hangedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hangUntil: null == hangUntil
          ? _value.hangUntil
          : hangUntil // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HangedNoteInfoImplCopyWith<$Res>
    implements $HangedNoteInfoCopyWith<$Res> {
  factory _$$HangedNoteInfoImplCopyWith(_$HangedNoteInfoImpl value,
          $Res Function(_$HangedNoteInfoImpl) then) =
      __$$HangedNoteInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, DateTime hangedAt, DateTime hangUntil});
}

/// @nodoc
class __$$HangedNoteInfoImplCopyWithImpl<$Res>
    extends _$HangedNoteInfoCopyWithImpl<$Res, _$HangedNoteInfoImpl>
    implements _$$HangedNoteInfoImplCopyWith<$Res> {
  __$$HangedNoteInfoImplCopyWithImpl(
      _$HangedNoteInfoImpl _value, $Res Function(_$HangedNoteInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hangedAt = null,
    Object? hangUntil = null,
  }) {
    return _then(_$HangedNoteInfoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      hangedAt: null == hangedAt
          ? _value.hangedAt
          : hangedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hangUntil: null == hangUntil
          ? _value.hangUntil
          : hangUntil // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HangedNoteInfoImpl implements _HangedNoteInfo {
  const _$HangedNoteInfoImpl(
      {required this.id, required this.hangedAt, required this.hangUntil});

  factory _$HangedNoteInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$HangedNoteInfoImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime hangedAt;
// id: DateTime
  @override
  final DateTime hangUntil;

  @override
  String toString() {
    return 'HangedNoteInfo(id: $id, hangedAt: $hangedAt, hangUntil: $hangUntil)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HangedNoteInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hangedAt, hangedAt) ||
                other.hangedAt == hangedAt) &&
            (identical(other.hangUntil, hangUntil) ||
                other.hangUntil == hangUntil));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, hangedAt, hangUntil);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HangedNoteInfoImplCopyWith<_$HangedNoteInfoImpl> get copyWith =>
      __$$HangedNoteInfoImplCopyWithImpl<_$HangedNoteInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HangedNoteInfoImplToJson(
      this,
    );
  }
}

abstract class _HangedNoteInfo implements HangedNoteInfo {
  const factory _HangedNoteInfo(
      {required final int id,
      required final DateTime hangedAt,
      required final DateTime hangUntil}) = _$HangedNoteInfoImpl;

  factory _HangedNoteInfo.fromJson(Map<String, dynamic> json) =
      _$HangedNoteInfoImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get hangedAt;
  @override // id: DateTime
  DateTime get hangUntil;
  @override
  @JsonKey(ignore: true)
  _$$HangedNoteInfoImplCopyWith<_$HangedNoteInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
