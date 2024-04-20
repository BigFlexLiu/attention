import 'package:attention/scenes/current_task/reflection.dart';
import 'package:attention/theme/theme.dart';
import 'package:attention/util/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../provider/task_provider.dart';

class TaskTimer extends StatefulWidget {
  const TaskTimer({super.key});

  @override
  State<TaskTimer> createState() => _TaskTimerState();
}

class _TaskTimerState extends State<TaskTimer> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
  );

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose(); // Need to call dispose function.
  }

  @override
  Widget build(BuildContext context) {
    final bool useHour = Provider.of<TaskProvider>(context, listen: false)
            .task
            .duration
            ?.inHours !=
        0;
    if (!_stopWatchTimer.isRunning) {
      Duration? duration =
          Provider.of<TaskProvider>(context, listen: false).task.duration;
      DateTime? startTime =
          Provider.of<TaskProvider>(context, listen: false).task.startTime;

      if (duration != null && startTime != null) {
        final int timeLeft =
            duration.inSeconds - DateTime.now().difference(startTime).inSeconds;
        _stopWatchTimer.setPresetTime(mSec: timeLeft * 1000);
        _stopWatchTimer.onStartTimer();
      }
    }
    return Container(
      color: taskComponentColors["time"]!.withOpacity(0.5),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                Provider.of<TaskProvider>(context, listen: false).task.title,
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: 0,
              builder: (context, snap) {
                final value = snap.data;
                final displayTime = StopWatchTimer.getDisplayTime(value ?? 0,
                    milliSecond: false, hours: useHour);
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      displayTime,
                      style: const TextStyle(
                          fontSize: 40,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TextButton(
                onPressed: () {
                  if (Provider.of<TaskProvider>(context, listen: false)
                      .task
                      .steps
                      .every((element) => element.isCompleted)) {
                    showDialog(
                        context: context,
                        builder: (BuilderContext) => AlertDialog(
                              title: const Text("Complete task?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Provider.of<TaskProvider>(context,
                                            listen: false)
                                        .complete();
                                    Navigator.pop(context);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Reflection()));
                                  },
                                  child: const Text("Ok"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel"),
                                ),
                              ],
                            ));
                    return;
                  }
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Auto complete all steps?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Provider.of<TaskProvider>(context,
                                      listen: false)
                                    ..completeAllSteps()
                                    ..complete();
                                  Navigator.pop(context, 'Yes');
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Reflection()));
                                },
                                child: const Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'No');
                                  Provider.of<TaskProvider>(context,
                                          listen: false)
                                      .complete();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Reflection()));
                                },
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                            ],
                          ));
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                child: const Text("Complete Task")),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('End work session?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'Yes');
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Reflection()));
                              },
                              child: const Text('Yes'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'No');
                              },
                              child: const Text('No'),
                            ),
                          ],
                        ));
              },
              child: const Text("End Task"),
            ),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Cancel Task?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                PlatformService.cancelTimer();
                                Provider.of<TaskProvider>(context,
                                        listen: false)
                                    .newTask();
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text('Yes'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'No');
                              },
                              child: const Text('No'),
                            ),
                          ],
                        ));
              },
              child: const Text("Cancel Task"),
            ),
          ]),
        ],
      ),
    );
  }
}
