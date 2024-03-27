import 'package:attention/provider/task_provider.dart';
import 'package:attention/scenes/create_task/next_task.dart';
import 'package:attention/scenes/current_task/ongoing_task.dart';
import 'package:attention/scenes/reflection/reflection.dart';
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              OptionButton("Next Task", () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const NextTask(),
                  ),
                );
              }),
              OptionButton("Records", () {}),
              OptionButton("Reflection", () {}),
              Expanded(child: Container()),
              const Text(
                'You have pushed the button this many times:',
              ),
              OptionButton("temp", () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OnGoingTask(),
                  ),
                );
              }),
              OptionButton("reflection", () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Reflection(),
                  ),
                );
              }),
            ])));
  }
}

class OptionButton extends StatelessWidget {
  const OptionButton(this.text, this.onClick, {super.key});

  final String text;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onClick, child: Text(text));
  }
}
