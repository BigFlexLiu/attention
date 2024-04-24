import 'package:attention/models/task.dart';
import 'package:attention/provider/all_tasks_provider.dart';
import 'package:attention/provider/task_filter_provider.dart';
import 'package:attention/scenes/create_task/create_task.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    final taskFilterProvider = Provider.of<TaskFilterProvider>(context);
    final filter = taskFilterProvider.filter;

    List<Task> tasks =
        filter.filterTasks(Provider.of<AllTasksProvider>(context).tasks);

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("History"),
          actions: [
            IconButton(
                tooltip: "Delete all tasks shown",
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Delete all tasks shown?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Provider.of<AllTasksProvider>(context,
                                            listen: false)
                                        .removeTasks(tasks);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Delete")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Cancel")),
                            ],
                          ));
                },
                icon: const Icon(Icons.delete)),
            IconButton(
              icon: const Icon(Icons.calendar_month),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HistoryCalendar()));
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
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            if (!task.completed)
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
                            if (!task.completed)
                              TextButton(
                                  onPressed: () {
                                    Provider.of<TaskProvider>(context,
                                        listen: false)
                                      ..setTask(task)
                                      ..setTaskParentTask(task);

                                    Navigator.of(context).pop();
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CreateTask()));
                                  },
                                  child: const Text(
                                      "Set as current task and edit")),
                            TextButton(
                                onPressed: () {
                                  Provider.of<AllTasksProvider>(context,
                                          listen: false)
                                      .removeTasks([task]);
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Delete")),
                          ]),
                        ));
              },
              child: LayeredTaskCard(task));
        }).toList()));
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
    final trailing = children.isEmpty
        ? const SizedBox()
        : IconButton(
            onPressed: () {
              setState(() {
                childrenVisible = !childrenVisible;
              });
            },
            icon: Icon(childrenVisible ? Icons.expand_more : Icons.expand_less),
            tooltip: childrenVisible
                ? "Show previous sessions"
                : "Hide previous sessions",
          );
    return Column(children: [
      TaskCard(widget.task, trailing),
      Visibility(
        visible: childrenVisible,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
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
