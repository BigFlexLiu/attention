import 'package:attention/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/task_provider.dart';

class Break extends StatelessWidget {
  const Break({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Break"),
      ),
      body: Container(
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
                    text: Provider.of<TaskProvider>(context).task.reward,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.blue),
                  ),
                ])),
            Image.asset("assets/images/soyjaks.png"),
          ],
        ),
      ),
    );
  }
}
