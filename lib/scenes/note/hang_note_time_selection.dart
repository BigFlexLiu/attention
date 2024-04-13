import 'package:attention/provider/hangedNotesProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../util/util.dart';

class HangNoteTimeSelection extends StatefulWidget {
  const HangNoteTimeSelection(this.note, {super.key});
  final note;

  @override
  State<HangNoteTimeSelection> createState() => _HangNoteTimeSelectionState();
}

class _HangNoteTimeSelectionState extends State<HangNoteTimeSelection> {
  DateTime _selectedDay = dayOf(DateTime.now());
  DateTime _focusedDay = dayOf(DateTime.now());
  CalendarFormat _calendarFormat = CalendarFormat.month;

  late HangedNotesProvider hangedNotesProvider;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    hangedNotesProvider = Provider.of<HangedNotesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Hang End Date"),
        actions: [
          IconButton(
              onPressed: () {
                hangedNotesProvider.hangNote(
                    widget.note, _selectedDay.add(const Duration(days: 1)));
                Navigator.pop(context);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(const Duration(days: 10 * 365)),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
                });
              },
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ],
        ),
      ),
    );
  }
}
