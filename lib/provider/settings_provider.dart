import 'package:attention/io/settings_io.dart';
import 'package:attention/theme/theme.dart';
import 'package:flutter/material.dart';

import '../models/settings.dart';

class SettingsProvider extends ChangeNotifier {
  late Settings settings;

  Future<void> init() async {
    settings = await readSettings();
  }

  void setPainterTheme(PainterTheme theme) {
    settings = settings.copyWith(painterTheme: theme);
    saveChange();
  }

  void toggleDefineSteps() {
    settings = settings.copyWith(
        taskDefinition: settings.taskDefinition
            .copyWith(defineSteps: !settings.taskDefinition.defineSteps));
    saveChange();
  }

  void toggleDefineProblems() {
    settings = settings.copyWith(
        taskDefinition: settings.taskDefinition
            .copyWith(defineProblems: !settings.taskDefinition.defineProblems));
    saveChange();
  }

  void toggleDefineReflect() {
    settings = settings.copyWith(
        taskDefinition: settings.taskDefinition
            .copyWith(defineReflect: !settings.taskDefinition.defineReflect));
    saveChange();
  }

  void toggleDefinePromise() {
    settings = settings.copyWith(
        taskDefinition: settings.taskDefinition
            .copyWith(definePromise: !settings.taskDefinition.definePromise));
    saveChange();
  }

  void saveChange() {
    writeSettings(settings);
    notifyListeners();
  }
}
