import 'package:flutter/material.dart';

import '../../models/task.dart';

class ReflectionDetails extends StatelessWidget {
  ReflectionDetails(this.task, {super.key});
  Task task;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          task.reflectionQuestion,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          task.reflectionAnswer,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
