import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'steps.freezed.dart';
part 'steps.g.dart';

@freezed
abstract class Steps with _$Steps {
  const factory Steps({
    required String title,
    required String description,
  }) = _Steps;

  factory Steps.fromJson(Map<String, dynamic> json) => _$StepsFromJson(json);
}
