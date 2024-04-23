import 'package:attention/provider/all_tasks_provider.dart';
import 'package:attention/provider/task_filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/task.dart';
import '../../util/util.dart';

class HistoryCalendar extends StatefulWidget {
  const HistoryCalendar({super.key});

  @override
  State<HistoryCalendar> createState() => _HistoryCalendarState();
}

class _HistoryCalendarState extends State<HistoryCalendar> {
  DateTime? _selectedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.disabled;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  List<Task> _selectedTasks = [];

  bool isSingleSelect = true;
  Map tasks = {};

  @override
  initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final allTasks = Provider.of<AllTasksProvider>(context).tasks;
    for (var task in allTasks) {
      if (tasks.containsKey(dayOf(task.startTime!))) {
        tasks[dayOf(task.startTime!)] = tasks[dayOf(task.startTime!)] + [task];
      } else {
        tasks[dayOf(task.startTime!)] = [task];
      }
    }
  }

  List<Task> _getTasksForDay(DateTime? day) {
    return tasks[day] ?? [];
  }

  List<Task> _getTasksForRange(
      List<Task> tasks, DateTime? start, DateTime? end) {
    List<Task> tasksInRange = [];
    for (var task in tasks) {
      if (task.startTime!.isAfter(end!)) {
        break;
      }
      if (task.startTime!.isAfter(start!) && task.startTime!.isBefore(end)) {
        tasksInRange.add(task);
      }
    }
    return tasksInRange;
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
    final tasks = Provider.of<AllTasksProvider>(context).tasks;

    final firstDay = tasks.isEmpty ? DateTime.now() : tasks.first.startTime!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("History Calendar"),
        actions: [
          IconButton(
            icon: Icon(isSingleSelect ? Icons.event : Icons.date_range),
            tooltip:
                isSingleSelect ? "Single Date Select" : "Range Date Select",
            onPressed: () {
              setState(() {
                isSingleSelect = !isSingleSelect;
                if (isSingleSelect) {
                  _rangeSelectionMode = RangeSelectionMode.disabled;
                  _rangeStart = null;
                  _rangeEnd = null;
                } else {
                  _rangeSelectionMode = RangeSelectionMode.toggledOn;
                  _selectedDay = null;
                }
              });
            },
          ),
          IconButton(
              onPressed: () {
                final taskFilterProvider =
                    Provider.of<TaskFilterProvider>(context, listen: false);
                if (isSingleSelect) {
                  taskFilterProvider.setTimeBoundFilter(_selectedDay!,
                      _selectedDay?.add(const Duration(days: 1)));
                } else if (_rangeStart != null && _rangeEnd != null) {
                  taskFilterProvider.setTimeBoundFilter(
                      _rangeStart!, _rangeEnd!.add(const Duration(days: 1)));
                }
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: DateTime.now(),
            firstDay: firstDay,
            lastDay: DateTime.now().add(const Duration(days: 365)),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            rangeSelectionMode: _rangeSelectionMode,
            startingDayOfWeek: StartingDayOfWeek.monday,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _selectedTasks = _getTasksForDay(selectedDay);
              });
            },
            onRangeSelected: (start, end, focusedDay) {
              setState(() {
                _rangeStart = start;
                _rangeEnd = end;
                _rangeSelectionMode = RangeSelectionMode.toggledOn;

                if (start != null && end != null) {
                  _selectedTasks = _getTasksForRange(tasks, start, end);
                } else {
                  _selectedTasks = [];
                }
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
                for (var task in _selectedTasks)
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
