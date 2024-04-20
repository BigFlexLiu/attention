import 'package:attention/models/substep.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/task_provider.dart';
import '../../theme/theme.dart';

class Steps extends StatefulWidget {
  const Steps({super.key});

  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: taskComponentColors["steps"]!.withOpacity(0.5),
      child: ListView(
        children: <Widget>[
          for (Substep step in Provider.of<TaskProvider>(context).task.steps)
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: ListTile(
                title: Text(step.title,
                    style: TextStyle(
                        decoration: step.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none)),
                trailing: IconButton(
                    icon: Icon(step.isCompleted ? Icons.clear : Icons.check),
                    onPressed: () {
                      Provider.of<TaskProvider>(context, listen: false)
                          .completeStep(step);
                    }),
              ),
            ),
          TextButton(
              onPressed: () => Provider.of<TaskProvider>(context, listen: false)
                  .completeAllSteps(),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: const Text("Complete all")),
        ],
      ),
    );
  }
}
