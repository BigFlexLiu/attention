import 'package:attention/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/task_provider.dart';
import '../../theme/celebrating_animator.dart';

class Break extends StatelessWidget {
  const Break({super.key});

  @override
  Widget build(BuildContext context) {
    final reward = Provider.of<TaskProvider>(context).task.reward;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Break"),
      ),
      body: CelebratingAnimator(
        child: Container(
          color: taskComponentColors["promise"]!.withOpacity(0.5),
          child: ListView(
            children: [
              const SizedBox(height: 16),
              Center(
                  child: Text(
                "Take a break! You've earned it!",
                style: Theme.of(context).textTheme.headlineSmall,
              )),
              const SizedBox(height: 16),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: "It's time for ",
                        style: Theme.of(context).textTheme.headlineSmall),
                    TextSpan(
                      text: reward == "" ? "a break" : reward,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Colors.blue),
                    ),
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
