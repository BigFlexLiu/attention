import 'package:attention/models/substep.dart';
import 'package:flutter/material.dart';

class StepsHistory extends StatelessWidget {
  StepsHistory(this.steps, {super.key});
  List<Substep> steps;

  Color oddColor = Colors.grey[200]!;
  Color evenColor = Colors.blue[100]!;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      for (var i = 0; i < steps.length; i++)
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
              tileColor: i % 2 == 0 ? evenColor : oddColor,
              title: Text(
                steps[i].title,
                style: TextStyle(
                    decoration: steps[i].isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              )),
        )
    ]);
  }
}
