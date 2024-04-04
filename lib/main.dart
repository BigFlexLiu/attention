import 'package:attention/provider/task_provider.dart';
import 'package:attention/scenes/create_task/next_task.dart';
import 'package:attention/scenes/current_task/ongoing_task.dart';
import 'package:attention/scenes/history/history.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => TaskProvider()),
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
      home: const MyHomePage(title: 'Home'),
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
  Widget build(BuildContext context) {
    final task = Provider.of<TaskProvider>(context);
    print(task.task);

    if (task.task.startTime != null &&
        task.task.startTime!.add(task.task.duration!).isAfter(DateTime.now()) &&
        !task.task.ended) {
      print("what");
      return const OnGoingTask();
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OptionButton("Create Task", () {
                task.newTask();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const NextTask(),
                  ),
                );
              }),
              OptionButton("History", () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const History(),
                  ),
                );
              }),
              OptionButton("Notes", () {}),
              SafeArea(child: Container()),
            ]));
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
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
