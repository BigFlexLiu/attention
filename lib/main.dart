import 'package:attention/provider/all_tasks_provider.dart';
import 'package:attention/provider/hangedNotesProvider.dart';
import 'package:attention/provider/settings_provider.dart';
import 'package:attention/provider/task_filter_provider.dart';
import 'package:attention/provider/task_provider.dart';
import 'package:attention/scenes/create_task/create_task.dart';
import 'package:attention/scenes/current_task/ongoing_task.dart';
import 'package:attention/scenes/history/history.dart';
import 'package:attention/scenes/note/notes_menu.dart';
import 'package:attention/scenes/settings/settings_menu.dart';
import 'package:attention/theme/circle_painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'hang_notes_gallery.dart';
import 'load_on_start.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure plugin services are initialized

  // Initialize the app
  await checkFirstLaunchAndUpdate(); // Check and update launch status
  final hangedNotesProvider = HangedNotesProvider()..pullHangedNotes();
  final taskProvider = TaskProvider();
  await taskProvider.init();
  final settingsProvider = SettingsProvider();
  await settingsProvider.init();
  final AllTasksProvider allTasksProvider = AllTasksProvider();
  await allTasksProvider.init();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => taskProvider),
      ChangeNotifierProvider(create: (context) => hangedNotesProvider),
      ChangeNotifierProvider(create: (context) => TaskFilterProvider()),
      ChangeNotifierProvider(create: (context) => settingsProvider),
      ChangeNotifierProvider(create: (context) => allTasksProvider),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Attention'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final task = Provider.of<TaskProvider>(context, listen: false);
      if (task.task.startTime != null &&
          task.task.startTime!
              .add(task.task.duration!)
              .isAfter(DateTime.now()) &&
          !task.task.ended) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const OnGoingTask(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<TaskProvider>(context);
    final hangedNotes = Provider.of<HangedNotesProvider>(context);

    Widget taskWidget = OptionButton("Create Task", () {
      task.newTask();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const CreateTask(),
        ),
      );
    });

    if (task.task.startTime != null &&
        task.task.startTime!.add(task.task.duration!).isAfter(DateTime.now()) &&
        !task.task.ended) {
      taskWidget = OptionButton("View Task", () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const OnGoingTask(),
          ),
        );
      });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: "Settings",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SettingsMenu(),
                  ),
                );
              },
            ),
          ],
        ),
        body: CustomPaint(
          painter: CirclePainter(
              painterTheme:
                  Provider.of<SettingsProvider>(context).settings.painterTheme),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: hangedNotes.hangedNotes.isNotEmpty ? 1 : 5,
                  child: Container(),
                ),
                if (hangedNotes.hangedNotes.isNotEmpty)
                  const Expanded(flex: 10, child: HangNotesGallery()),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    taskWidget,
                    OptionButton("History", () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const History(),
                        ),
                      );
                    }),
                    OptionButton("Notes", () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const NotesMenu(),
                        ),
                      );
                    }),
                  ],
                ),
                Expanded(
                  flex: hangedNotes.hangedNotes.isEmpty ? 2 : 1,
                  child: Container(),
                ),
              ]),
        ));
  }
}

class OptionButton extends StatelessWidget {
  const OptionButton(this.text, this.onClick, {super.key});

  final String text;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClick,
      child: Text(
        text,
      ),
    );
  }
}
