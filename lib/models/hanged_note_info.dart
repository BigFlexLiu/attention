import 'package:freezed_annotation/freezed_annotation.dart';

part 'hanged_note_info.freezed.dart';
part 'hanged_note_info.g.dart';

@freezed
abstract class HangedNoteInfo with _$HangedNoteInfo {
  const factory HangedNoteInfo({
    required int id,
    required DateTime hangedAt, // id: DateTime
    required DateTime hangUntil, // id: Duration
  }) = _HangedNoteInfo;

  factory HangedNoteInfo.fromJson(Map<String, dynamic> json) =>
      _$HangedNoteInfoFromJson(json);
}
