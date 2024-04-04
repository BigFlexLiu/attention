import 'package:flutter/material.dart';

class ImportanceHistory extends StatelessWidget {
  ImportanceHistory(this.personalImportance, {super.key});
  String personalImportance;

  @override
  Widget build(BuildContext context) {
    return Text(personalImportance);
  }
}
