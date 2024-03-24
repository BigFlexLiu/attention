import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../provider/task_provider.dart';

/// Flutter code sample for [CupertinoTimerPicker].

void main() => runApp(const TimeSetter());

class TimeSetter extends StatelessWidget {
  const TimeSetter({super.key});

  @override
  Widget build(BuildContext context) {
    return const TimePickerExample();
  }
}

class TimePickerExample extends StatefulWidget {
  const TimePickerExample({super.key});

  @override
  State<TimePickerExample> createState() => _TimePickerExampleState();
}

class _TimePickerExampleState extends State<TimePickerExample> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTimerPicker(
      mode: CupertinoTimerPickerMode.hms,
      initialTimerDuration: const Duration(hours: 0, minutes: 25, seconds: 0),
      onTimerDurationChanged: (Duration newTimerDuration) {
        Provider.of<TaskProvider>(context, listen: false)
            .setTaskTime(newTimerDuration);
      },
    );
  }
}
