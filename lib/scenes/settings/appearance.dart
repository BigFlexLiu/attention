import 'package:attention/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/settings_provider.dart';

class Appearance extends StatefulWidget {
  const Appearance({super.key});

  @override
  State<Appearance> createState() => _AppearanceState();
}

class _AppearanceState extends State<Appearance> {
  @override
  Widget build(BuildContext context) {
    PainterTheme selectedValue =
        Provider.of<SettingsProvider>(context).settings.painterTheme;

    void handleRadioValueChange(PainterTheme? value) {
      setState(() {
        Provider.of<SettingsProvider>(context, listen: false)
            .setPainterTheme(value ?? PainterTheme.none);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Appearance"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("Background Ornamentation",
                style: Theme.of(context).textTheme.titleLarge),
          ),
          for (PainterTheme theme in PainterTheme.values)
            RadioListTile<PainterTheme>(
              title: Text(painterThemeName[theme]!),
              value: theme,
              groupValue: selectedValue,
              onChanged: handleRadioValueChange,
              toggleable: true,
            ),
        ],
      ),
    );
  }
}
