import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'substep.freezed.dart';
part 'substep.g.dart';

@freezed
abstract class Substep with _$Substep {
  const factory Substep({
    required String title,
    required bool isCompleted,
  }) = _Substep;

  factory Substep.fromJson(Map<String, dynamic> json) =>
      _$SubstepFromJson(json);
}
