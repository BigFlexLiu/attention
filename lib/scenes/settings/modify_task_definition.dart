import 'package:attention/models/settings.dart';
import 'package:attention/provider/settings_provider.dart';
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
      Definition("Define Steps", settings.taskDefinition.defineSteps,
          settingsProvider.toggleDefineSteps),
      Definition("Define Problems", settings.taskDefinition.defineProblems,
          settingsProvider.toggleDefineProblems),
      Definition("Define Reflect", settings.taskDefinition.defineReflect,
          settingsProvider.toggleDefineReflect),
      Definition("Define Promise", settings.taskDefinition.definePromise,
          settingsProvider.toggleDefinePromise),
    ];

    return Scaffold(
        appBar: AppBar(
          title: const Text("Modify Task Definition"),
        ),
        body: ListView(
          children: definitions
              .map((e) =>
                  DefinitionToggleWidget(e.title, e.isToggled, e.onToggle))
              .toList(),
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
          color: isToggled ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(8.0)),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                onToggle();
              },
              icon: Icon(isToggled ? Icons.check : Icons.close)),
        ],
      ),
    );
  }
}
