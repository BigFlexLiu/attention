import 'package:attention/provider/hangedNotesProvider.dart';
import 'package:attention/scenes/note/hang_note_time_selection.dart';
import 'package:attention/scenes/note/simple_note_editor.dart';
import 'package:attention/scenes/note/todo_note_editor.dart';
import 'package:attention/scenes/note/todonote_view.dart';
import 'package:attention/util/util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/hanged_note_info.dart';
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
            return SimpleNoteDisplay(note, e);
          } else if (note is TodoNote) {
            return TodoNoteDisplay(note, e);
          }
          return Container();
        }).toList(),
        options: CarouselOptions(
          height: double.infinity,
          enableInfiniteScroll: false,
        ));
  }
}

class NoteDisplay extends StatefulWidget {
  const NoteDisplay(this.title, this.content, this.hangedNote, this.getEditor,
      {super.key});
  final String title;
  final Widget content;
  final dynamic hangedNote;
  final Widget Function() getEditor;

  @override
  State<NoteDisplay> createState() => _NoteDisplayState();
}

class _NoteDisplayState extends State<NoteDisplay> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => widget.getEditor()));
              },
              child: Text(widget.title,
                  style: Theme.of(context).textTheme.headlineMedium),
            ),
            Expanded(
              child: Container(),
            ),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                          title: Text(
                              "Hang until ${fullDateDisplay(widget.hangedNote.hangUntil)}"),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Provider.of<HangedNotesProvider>(context,
                                            listen: false)
                                        .deleteHangedNoteById(
                                            widget.hangedNote.id);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Take down")),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HangNoteTimeSelection(
                                                  widget.hangedNote)));
                                },
                                child: const Text("Change end date"),
                              )
                            ],
                          )));
                },
                icon: const Icon(Icons.calendar_month),
                tooltip:
                    "Hang until ${fullDateDisplay(widget.hangedNote.hangUntil)}"),
          ],
        ),
        widget.content,
      ],
    );
  }
}

class SimpleNoteDisplay extends StatefulWidget {
  SimpleNoteDisplay(this.simpleNote, this.hangedNoteInfo, {super.key});
  SimpleNote simpleNote;
  HangedNoteInfo hangedNoteInfo;

  @override
  State<SimpleNoteDisplay> createState() => _SimpleNoteDisplayState();
}

class _SimpleNoteDisplayState extends State<SimpleNoteDisplay> {
  @override
  Widget build(BuildContext context) {
    getEditor() => SimpleNoteEditor(
        Provider.of<HangedNotesProvider>(context, listen: false)
            .pullHangedNotes,
        note: widget.simpleNote);
    return NoteDisplay(widget.simpleNote.title, Text(widget.simpleNote.content),
        widget.hangedNoteInfo, getEditor);
  }
}

class TodoNoteDisplay extends StatefulWidget {
  TodoNoteDisplay(this.note, this.hangedNoteInfo, {super.key});
  TodoNote note;
  HangedNoteInfo hangedNoteInfo;

  @override
  State<TodoNoteDisplay> createState() => _TodoNoteDisplayState();
}

class _TodoNoteDisplayState extends State<TodoNoteDisplay> {
  @override
  Widget build(BuildContext context) {
    getEditor() => TodoNoteEditor(
        Provider.of<HangedNotesProvider>(context, listen: false)
            .pullHangedNotes,
        note: widget.note);
    return NoteDisplay(
        widget.note.title,
        TodoNoteTree(treeNodeFromTodoNote(widget.note)),
        widget.hangedNoteInfo,
        getEditor);
  }
}
