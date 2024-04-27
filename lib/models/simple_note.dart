import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'simple_note.freezed.dart';
part 'simple_note.g.dart';

@freezed
abstract class SimpleNote with _$SimpleNote {
  const factory SimpleNote({
    required int id,
    required String title,
    required String content,
    required DateTime createdAt,
    required DateTime? autoDeleteAt,
  }) = _SimpleNote;

  factory SimpleNote.fromJson(Map<String, dynamic> json) =>
      _$SimpleNoteFromJson(json);
}
