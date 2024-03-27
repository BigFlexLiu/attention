import 'package:attention/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../provider/task_provider.dart';

class Timer extends StatefulWidget {
  const Timer({super.key});

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
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
          Expanded(
            child: StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: 0,
                builder: (context, snap) {
                  final value = snap.data;
                  final displayTime = StopWatchTimer.getDisplayTime(value ?? 0,
                      milliSecond: false, hours: false);
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
          ),
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      child: const Text("End Task")),
                ]),
          ),
        ],
      ),
    );
  }
}
