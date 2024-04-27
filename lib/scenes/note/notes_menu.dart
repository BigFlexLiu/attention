import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:animated_tree_view/tree_view/widgets/expansion_indicator.dart';
import 'package:animated_tree_view/tree_view/widgets/indent.dart';
import 'package:attention/io/notes_io.dart';
import 'package:attention/models/simple_note.dart';
import 'package:attention/scenes/note/simple_note_editor.dart';
import 'package:attention/scenes/note/hang_note_time_selection.dart';
import 'package:attention/scenes/note/todo_note_editor.dart';
import 'package:attention/scenes/note/todonote_view.dart';
import 'package:attention/theme/theme.dart';
import 'package:flutter/material.dart';

import '../../models/todo_note.dart';
import '../../util/util.dart';
import 'make_note.dart';

class NotesMenu extends StatefulWidget {
  const NotesMenu({super.key});

  @override
  State<NotesMenu> createState() => _NotesMenuState();
}

class _NotesMenuState extends State<NotesMenu> {
  NoteFilter filter = NoteFilter.all;
  Future<List> _notes = Future.delayed(Duration.zero, () => []);

  Future<void> fetchNotes() async {
    setState(() {
      _notes = readNotes();
    });
  }

  Future<List> readNotes() async {
    try {
      final simpleNotes = await readSimpleNotes();
      final todoNotes = await readTodoNotes();

      return mergeSortNotes(simpleNotes, todoNotes);
    } catch (e) {
      return [];
    }
  }

  NoteFilter nextFilter(NoteFilter filter) {
    if (filter == NoteFilter.all) {
      return NoteFilter.simple;
    } else if (filter == NoteFilter.simple) {
      return NoteFilter.todo;
    } else {
      return NoteFilter.all;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _notes,
        builder: (context, snapshot) {
          var notesDisplay = snapshot.data == null
              ? const [CircularProgressIndicator()]
              : snapshot.data?.where((note) {
                  if (filter == NoteFilter.all) {
                    return true;
                  } else if (filter == NoteFilter.simple) {
                    return note is SimpleNote;
                  } else {
                    return note is TodoNote;
                  }
                }).map((note) {
                  if (note is SimpleNote) {
                    return SimpleNoteDisplay(fetchNotes, note);
                  } else {
                    return TodoNoteDisplay(fetchNotes, note);
                  }
                }).toList() as List<Widget>;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Notes'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: "Add Note",
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MakeNote(fetchNotes)));
                  },
                ),
                IconButton(
                  icon: Icon(filterIcon[filter]!.icon),
                  tooltip: filterIcon[filter]!.hintText,
                  onPressed: () {
                    setState(() {
                      filter = nextFilter(filter);
                    });
                  },
                ),
              ],
            ),
            body: ListView(
              children: notesDisplay,
            ),
          );
        });
  }
}

class SimpleNoteDisplay extends StatefulWidget {
  const SimpleNoteDisplay(this.loadNotes, this.simpleNote, {super.key});
  final VoidCallback loadNotes;
  final SimpleNote simpleNote;

  @override
  State<SimpleNoteDisplay> createState() => _SimpleNoteDisplayState();
}

class _SimpleNoteDisplayState extends State<SimpleNoteDisplay> {
  late BuildContext _scaffoldContext;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scaffoldContext = context;
  }

  @override
  Widget build(BuildContext context) {
    showLongPressDialogue() => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SimpleNoteEditor(widget.loadNotes,
                          note: widget.simpleNote)));
                },
                child: const Text("View"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          HangNoteTimeSelection(widget.simpleNote)));
                },
                child: const Text("Hang"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  showDateTimePickers(context, widget.simpleNote);
                },
                child: const Text("Schedule Delete"),
              ),
              TextButton(
                onPressed: () {
                  deleteSimpleNoteById(widget.simpleNote.id)
                      .then((value) => widget.loadNotes());
                  Navigator.of(context).pop();
                },
                child: const Text("Delete"),
              ),
            ],
          ));
        });
    return InkWell(
      onLongPress: showLongPressDialogue,
      child: ExpansionTile(
          title: Text(widget.simpleNote.title != ""
              ? widget.simpleNote.title
              : "untitled"),
          subtitle: Text(fullDateDisplay(widget.simpleNote.createdAt)),
          children: [
            ListTile(
                title: Text(widget.simpleNote.content),
                onLongPress: showLongPressDialogue)
          ]),
    );
  }

  Future<void> showDateTimePickers(
      BuildContext context, SimpleNote note) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: _scaffoldContext,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        editSimpleNoteById(
          note.id,
          note.title,
          note.content,
          DateTime(pickedDate.year, pickedDate.month, pickedDate.day,
              pickedTime.hour, pickedTime.minute),
        ).then((value) => widget.loadNotes());
      }
    }
  }
}

class TodoNoteDisplay extends StatelessWidget {
  const TodoNoteDisplay(this.updateNotes, this.todoNote, {super.key});
  final VoidCallback updateNotes;
  final TodoNote todoNote;

  @override
  Widget build(BuildContext context) {
    TreeNode node = treeNodeFromTodoNote(todoNote);
    return InkWell(
      onLongPress: () => showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TodoNoteView(updateNotes, todoNote),
                    ));
                  },
                  child: const Text("View"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          TodoNoteEditor(updateNotes, note: todoNote),
                    ));
                  },
                  child: const Text("Edit"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HangNoteTimeSelection(todoNote),
                    ));
                  },
                  child: const Text("Hang"),
                ),
                TextButton(
                  onPressed: () {
                    deleteTodoNoteById(todoNote.id!)
                        .then((value) => updateNotes());
                    Navigator.of(context).pop();
                  },
                  child: const Text("Delete"),
                ),
              ],
            ));
          }),
      child: ExpansionTile(
          title: Text(todoNote.title == "" ? todoNote.title : "untitled"),
          subtitle: Text(fullDateDisplay(todoNote.createdAt!)),
          children: [
            TreeView.simple(
              shrinkWrap: true,
              tree: node,
              showRootNode: false,
              expansionIndicatorBuilder: (context, node) =>
                  ChevronIndicator.rightDown(
                tree: node,
                color: Colors.blue[700],
                padding: const EdgeInsets.all(8),
              ),
              indentation: const Indentation(style: IndentStyle.squareJoint),
              onItemTap: (item) {},
              builder: (context, node) => Card(
                color: todoNoteTreeColorMapper[
                    node.level.clamp(0, todoNoteTreeColorMapper.length - 1)],
                child: ListTile(
                  title: Text(node.data ?? "",
                      style: TextStyle(
                        decoration: treeNodeIsDone(node)
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      )),
                ),
              ),
            ),
          ]),
    );
  }
}

enum NoteFilter { simple, todo, all }

final Map<NoteFilter, FilterData> filterIcon = {
  NoteFilter.all:
      FilterData(NoteFilter.all, "Filter by all", Icons.list), // All notes
  NoteFilter.todo: FilterData(
      NoteFilter.all, "Filter by todo notes", Icons.segment), // Todo notes
  NoteFilter.simple: FilterData(
      NoteFilter.all, "Filter by simple notes", Icons.notes), // Simple notes
};

class FilterData {
  final NoteFilter filter;
  final String hintText;
  final IconData icon;

  FilterData(this.filter, this.hintText, this.icon);
}

List mergeSortNotes(List<SimpleNote> simpleNotes, List<TodoNote> todoNotes) {
  List mergedNotes = [];

  int i = 0, j = 0;
  while (i < simpleNotes.length && j < todoNotes.length) {
    if (simpleNotes[i].createdAt.isAfter(todoNotes[j].createdAt!)) {
      mergedNotes.add(simpleNotes[i]);
      i++;
    } else {
      mergedNotes.add(todoNotes[j]);
      j++;
    }
  }
  mergedNotes.addAll(simpleNotes.sublist(i));
  mergedNotes.addAll(todoNotes.sublist(j));

  return mergedNotes;
}
