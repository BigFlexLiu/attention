import 'package:attention/models/settings.dart';
import 'package:attention/provider/settings_provider.dart';
import 'package:attention/scenes/create_task/create_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModifyTaskDefinition extends StatefulWidget {
  const ModifyTaskDefinition({super.key});

  @override
  State<ModifyTaskDefinition> createState() => _ModifyTaskDefinitionState();
}

class _ModifyTaskDefinitionState extends State<ModifyTaskDefinition> {
  @override
  Widget build(BuildContext context) {
    Settings settings = Provider.of<SettingsProvider>(context).settings;
    SettingsProvider settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    final List<Definition> definitions = [
      Definition("Steps", settings.taskDefinition.defineSteps,
          settingsProvider.toggleDefineSteps),
      Definition("Problems", settings.taskDefinition.defineProblems,
          settingsProvider.toggleDefineProblems),
      Definition("Reflect", settings.taskDefinition.defineReflect,
          settingsProvider.toggleDefineReflect),
      Definition("Promise", settings.taskDefinition.definePromise,
          settingsProvider.toggleDefinePromise),
    ];

    final bottomSheet = Container(
      color: Theme.of(context).colorScheme.inversePrimary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...definitions
              .map((e) => Expanded(
                    child: DefinitionToggleWidget(
                        e.title, e.isToggled, e.onToggle),
                  ))
              .toList()
        ],
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text("Modify Task Definition"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        bottomSheet: bottomSheet,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [const Expanded(child: CreateTask(isDemo: true)), bottomSheet],
        ));
  }
}

class Definition {
  final String title;
  final bool isToggled;
  final VoidCallback onToggle;

  Definition(this.title, this.isToggled, this.onToggle);
}

class DefinitionToggleWidget extends StatelessWidget {
  const DefinitionToggleWidget(
    this.title,
    this.isToggled,
    this.onToggle, {
    super.key,
  });
  final bool isToggled;
  final String title;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: onToggle,
          child: Text(
            title,
            style: TextStyle(color: isToggled ? Colors.green : Colors.red),
          ),
        ),
      ],
    );
  }
}
