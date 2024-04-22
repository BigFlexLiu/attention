import 'package:attention/io/tasks_io.dart';
import 'package:attention/models/task.dart';
import 'package:attention/provider/task_filter_provider.dart';
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
  int i = 0;

  final filterDisplay = {
    TaskStatusFilter.completed:
        FilterDetails(Icons.check_circle, "Show Completed"),
    TaskStatusFilter.all: FilterDetails(Icons.list, "Show All"),
    TaskStatusFilter.incomplete: FilterDetails(Icons.cancel, "Show Incomplete"),
  };

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    previousTasks = readPastTasks();
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
          final taskFilterProvider = Provider.of<TaskFilterProvider>(context);
          final filter = taskFilterProvider.filter;
          List<Task> tasks = filter.filterTasks(snapshot.data!);
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
                          builder: (context) =>
                              HistoryCalendar(snapshot.data!)));
                    },
                  ),
                  IconButton(
                      tooltip: filterDisplay[filter.taskStatusFilter]!.title,
                      onPressed: () {
                        final newTaskStutus = TaskStatusFilter.values[
                            (filter.taskStatusFilter.index + 1) %
                                TaskStatusFilter.values.length];
                        taskFilterProvider.setTaskStatusFilter(newTaskStutus);
                      },
                      icon: Icon(filterDisplay[filter.taskStatusFilter]!.icon)),
                ],
              ),
              body: ListView(
                  children: tasks.reversed.map((task) {
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
                                                ..restartTask(task);
                                              Navigator.of(context).pop();
                                              pop();
                                            },
                                            child: const Text(
                                                "Set as current task and start")),
                                        TextButton(
                                            onPressed: () {
                                              Provider.of<TaskProvider>(context,
                                                  listen: false)
                                                ..setTask(task)
                                                ..setTaskParentTask(task);

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
                    child: LayeredTaskCard(task));
              }).toList()));
        }
      },
    );
  }

  void pop() {
    Navigator.pop(context);
  }
}

class LayeredTaskCard extends StatefulWidget {
  LayeredTaskCard(this.task, {super.key});
  Task task;

  @override
  State<LayeredTaskCard> createState() => _LayeredTaskCardState();
}

class _LayeredTaskCardState extends State<LayeredTaskCard> {
  List<Task> children = [];
  bool childrenVisible = false;

  void fillChildren(Task task) {
    if (task.parentTask != null) {
      children.add(task.parentTask!);
      fillChildren(task.parentTask!);
    }
  }

  @override
  void initState() {
    fillChildren(widget.task);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TaskCard(
          widget.task,
          IconButton(
            onPressed: () {
              setState(() {
                childrenVisible = !childrenVisible;
              });
            },
            icon:
                Icon(childrenVisible ? Icons.visibility_off : Icons.visibility),
            tooltip: childrenVisible
                ? "Show previous sessions"
                : "Hide previous sessions",
          )),
      Visibility(
        visible: childrenVisible,
        child: Column(
          children: children
              .map((task) => TaskCard(
                    task,
                    const SizedBox(
                      width: 0,
                      height: 0,
                    ),
                  ))
              .toList(),
        ),
      ),
    ]);
  }

  Card TaskCard(task, trailing) {
    final backgroundColor = task.completed
        ? Theme.of(context).colorScheme.inversePrimary
        : Theme.of(context).colorScheme.background;

    Duration duration = task.duration ?? Duration.zero;
    return Card(
        color: backgroundColor,
        child: ExpansionTile(
          title: Text(task.title),
          subtitle:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Started: ${fullDateDisplay(task.startTime!)}"),
            Text("Duration: ${durationDisplay(duration)}"),
            Text(task.personalImportance),
          ]),
          trailing: trailing,
          children: [
            DetailTabs(task),
          ],
        ));
  }
}

class FilterDetails {
  final IconData icon;
  final String title;

  FilterDetails(this.icon, this.title);
}
