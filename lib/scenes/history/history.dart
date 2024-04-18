import 'package:attention/io/io_functions.dart';
import 'package:attention/models/task.dart';
import 'package:attention/scenes/create_task/next_task.dart';
import 'package:attention/scenes/history/details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/task_provider.dart';
import '../../util/services.dart';
import '../../util/util.dart';
import 'history_calendar.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late Future<List<Task>> previousTasks;
  Filter currentFilter = Filter.all;

  final filterDisplay = {
    Filter.all: FilterDetails(Icons.list, "Show All"),
    Filter.completed: FilterDetails(Icons.check_circle, "Show Completed"),
    Filter.incomplete: FilterDetails(Icons.cancel, "Show Incomplete"),
  };

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    previousTasks = readPastTasks(); // Call your read function here
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: previousTasks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else {
          List<Task> tasks = _filterTasks(currentFilter, snapshot.data!);
          return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: const Text("History"),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.calendar_month),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder:
                              // (context) => TableComplexExample()));
                              (context) => HistoryCalendar(snapshot.data!)));
                    },
                  ),
                  IconButton(
                      tooltip: filterDisplay[currentFilter]!.title,
                      onPressed: () {
                        setState(() {
                          currentFilter = Filter.values[
                              (currentFilter.index + 1) % Filter.values.length];
                        });
                      },
                      icon: Icon(filterDisplay[currentFilter]!.icon)),
                ],
              ),
              body: ListView(
                  children: tasks.reversed.map((task) {
                Duration duration = task.duration ?? Duration.zero;

                final cardColor = task.completed
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.background;

                return GestureDetector(
                    onLongPress: () {
                      if (!task.completed) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              final durationInSeconds =
                                                  task.duration!.inSeconds;
                                              PlatformService.startService(
                                                  durationInSeconds);
                                              Provider.of<TaskProvider>(context,
                                                  listen: false)
                                                ..setTask(task)
                                                ..restartTask(task.id);
                                              Navigator.of(context).pop();
                                              pop();
                                            },
                                            child: const Text(
                                                "Set as current task and start")),
                                        TextButton(
                                            onPressed: () {
                                              Provider.of<TaskProvider>(context,
                                                      listen: false)
                                                  .setTask(task);
                                              Navigator.of(context).pop();
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const NextTask()));
                                            },
                                            child: const Text(
                                                "Set as current task and edit")),
                                      ]),
                                ));
                      }
                    },
                    child: Card(
                        color: cardColor,
                        child: ExpansionTile(
                          title: Text(task.title),
                          subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Started: ${fullDateDisplay(task.startTime!)}"),
                                Text("Duration: ${durationDisplay(duration)}"),
                                Text(task.personalImportance),
                              ]),
                          children: [
                            DetailTabs(task),
                          ],
                        )));
              }).toList()));
        }
      },
    );
  }

  void pop() {
    Navigator.pop(context);
  }

  List<Task> _filterTasks(Filter filter, List<Task> tasks) {
    if (filter == Filter.all) {
      return tasks;
    } else if (filter == Filter.completed) {
      return tasks.where((task) => task.completed).toList();
    } else {
      return tasks.where((task) => !task.completed).toList();
    }
  }
}

enum Filter {
  all,
  completed,
  incomplete,
}

class FilterDetails {
  final IconData icon;
  final String title;

  FilterDetails(this.icon, this.title);
}
