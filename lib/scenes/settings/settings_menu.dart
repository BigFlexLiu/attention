import 'package:flutter/material.dart';

import 'modify_task_definition.dart';

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({super.key});

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Modify Task Definition"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ModifyTaskDefinition(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Appearance"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Delete Data"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Reset"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}