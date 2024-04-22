import 'package:attention/provider/hangedNotesProvider.dart';
import 'package:attention/scenes/note/todonote_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/simple_note.dart';
import 'models/todo_note.dart';

class HangNotesGallery extends StatelessWidget {
  const HangNotesGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items:
            Provider.of<HangedNotesProvider>(context).hangedNotesInfo.map((e) {
          final note =
              Provider.of<HangedNotesProvider>(context).getHangedNoteById(e.id);
          if (note is SimpleNote) {
            return SimpleNoteDisplay(note, e.hangedAt, e.hangUntil);
          } else if (note is TodoNote) {
            return TodoNoteDisplay(note, e.hangedAt, e.hangUntil);
          }
          return Container();
        }).toList(),
        options: CarouselOptions(
          height: double.infinity,
          // height: 400.0,
          enableInfiniteScroll: false,
        ));
  }
}

class SimpleNoteDisplay extends StatefulWidget {
  SimpleNoteDisplay(this.simpleNote, this.hangAt, this.hangUntil, {super.key});
  SimpleNote simpleNote;
  DateTime hangAt;
  DateTime hangUntil;

  @override
  State<SimpleNoteDisplay> createState() => _SimpleNoteDisplayState();
}

class _SimpleNoteDisplayState extends State<SimpleNoteDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(widget.simpleNote.title,
              style: Theme.of(context).textTheme.headlineMedium),
          Text(widget.simpleNote.content),
        ],
      ),
    );
  }
}

class TodoNoteDisplay extends StatefulWidget {
  TodoNoteDisplay(this.note, this.hangAt, this.hangUntil, {super.key});
  TodoNote note;
  DateTime hangAt;
  DateTime hangUntil;

  @override
  State<TodoNoteDisplay> createState() => _TodoNoteDisplayState();
}

class _TodoNoteDisplayState extends State<TodoNoteDisplay> {
  @override
  Widget build(BuildContext context) {
    final updateFunc = Provider.of<HangedNotesProvider>(context, listen: false)
        .pullHangedNotes;
    return TodoNoteView(updateFunc, widget.note);
  }
}
