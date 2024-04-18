
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/task.dart';
import '../../util/util.dart';

class HistoryCalendar extends StatefulWidget {
  HistoryCalendar(this.tasks, {super.key});
  List<Task> tasks;

  @override
  State<HistoryCalendar> createState() => _HistoryCalendarState();
}

class _HistoryCalendarState extends State<HistoryCalendar> {
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  Map tasks = {};

  @override
  initState() {
    super.initState();
    for (var task in widget.tasks) {
      if (tasks.containsKey(dayOf(task.startTime!))) {
        tasks[dayOf(task.startTime!)] = tasks[dayOf(task.startTime!)] + [task];
      } else {
        tasks[dayOf(task.startTime!)] = [task];
      }
    }
  }

  List<Task> _getTasksForDay(DateTime day) {
    return tasks[day] ?? [];
  }

  defaultcalendarBuilder(context, day, focusedDay, isSelected) {
    var eventCount = tasks[day]?.length ?? 0;
    return Container(
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.white,
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: const TextStyle().copyWith(fontSize: 16.0),
                ),
              ),
            ),
          ),
          if (eventCount > 0)
            Positioned(
              right: 8,
              bottom: 0,
              child: Text('$eventCount',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: isSelected ? Colors.white : Colors.blue,
                      )),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final firstDay = widget.tasks.first.startTime!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("History Calendar"),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: DateTime.now(),
            firstDay: firstDay,
            lastDay: DateTime.now().add(const Duration(days: 365)),
            startingDayOfWeek: StartingDayOfWeek.monday,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            calendarStyle: const CalendarStyle(
              canMarkersOverflow: false,
              isTodayHighlighted: false,
              outsideDaysVisible: false,
              markersMaxCount: 0,
            ),
            eventLoader: _getTasksForDay,
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) =>
                  defaultcalendarBuilder(context, day, focusedDay, false),
              selectedBuilder: (context, day, focusedDay) =>
                  defaultcalendarBuilder(context, day, focusedDay, true),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                for (var task in _getTasksForDay(_selectedDay))
                  ListTile(
                    title: Text(task.title),
                    subtitle: Text(
                        "From ${DateFormat("h:mm a").format(task.startTime!)} for ${durationDisplay(task.duration!)}"),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
