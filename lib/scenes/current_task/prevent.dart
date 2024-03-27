import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/problem_solution.dart';
import '../../provider/task_provider.dart';
import '../../theme.dart';

class Prevent extends StatelessWidget {
  const Prevent({super.key});

  @override
  Widget build(BuildContext context) {
    List<ProblemSolution> problemSolutions =
        Provider.of<TaskProvider>(context).task.problemSolutions;
    return Container(
      color: taskComponentColors["problemSolutions"]!.withOpacity(0.5),
      padding: const EdgeInsets.all(24.0),
      child: ListView(children: [
        for (int i = 0; i < problemSolutions.length; i++)
          PreventCard(problemSolutions[i])
      ]),
    );
  }
}

class PreventCard extends StatelessWidget {
  const PreventCard(this.problemSolution, {super.key});
  final ProblemSolution problemSolution;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(problemSolution.problem),
        subtitle: Text(problemSolution.solution),
      ),
    );
  }
}
