import 'dart:math';

import 'package:attention/provider/all_tasks_provider.dart';
import 'package:attention/scenes/current_task/break.dart';
import 'package:attention/scenes/current_task/ongoing_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/task_provider.dart';
import '../../util/services.dart';

class Reflection extends StatefulWidget {
  const Reflection({super.key});

  @override
  State<Reflection> createState() => _ReflectionState();
}

class _ReflectionState extends State<Reflection> {
  final reflectionController = TextEditingController();
  final question =
      reflectionQuestions[Random().nextInt(reflectionQuestions.length)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reflection"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Use any icon you prefer
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const OnGoingTask()));
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          Text(
            question,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          TextField(
            controller: reflectionController,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: "Type your reflection here",
              border: OutlineInputBorder(),
            ),
          ),
          Row(
            children: [
              Expanded(child: Container()),
              ElevatedButton(
                onPressed: () {
                  reflectionController.clear();
                  setState(() {
                    reflectionController.clear();
                  });
                },
                child: const Text("Clear"),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () async {
                  PlatformService.cancelTimer();
                  final taskProvider =
                      Provider.of<TaskProvider>(context, listen: false)
                        ..updateReflection(question, reflectionController.text);
                  await taskProvider.endTask();
                  Provider.of<AllTasksProvider>(context, listen: false)
                      .reload();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Break()));
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

final reflectionQuestions = [
  "What have you achieved?",
  "What was one thing you did that you can be proud of?",
  "What went well?",
  "What distraction/challenge did you face? How did you overcome it?",
  "If you were to do this task again, what would you change?",
  "How do you apply what you've learned from this task to your future tasks?",
  "How do you feel after doing this task?",
  "What do you want to do next?",
];
