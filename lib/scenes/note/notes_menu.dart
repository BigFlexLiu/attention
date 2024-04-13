import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:animated_tree_view/tree_view/widgets/expansion_indicator.dart';
import 'package:animated_tree_view/tree_view/widgets/indent.dart';
import 'package:attention/io/notes_io.dart';
import 'package:attention/models/simple_note.dart';
import 'package:attention/scenes/note/empty_note.dart';
import 'package:attention/scenes/note/hang_note_time_selection.dart';
import 'package:attention/scenes/note/todo_note_edit.dart';
import 'package:attention/scenes/note/todonote_view.dart';
import 'package:attention/theme.dart';
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
                  icon: const Icon(Icons.calendar_month),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(filterIcon[filter]!.icon),
                  onPressed: () {
                    Icons.list; // All notes
                    Icons.segment; // Todo notes
                    Icons.notes; // Simple notes
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

class SimpleNoteDisplay extends StatelessWidget {
  const SimpleNoteDisplay(this.loadNotes, this.simpleNote, {super.key});
  final VoidCallback loadNotes;
  final SimpleNote simpleNote;

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
                      builder: (context) =>
                          EmptyNote(loadNotes, note: simpleNote)));
                },
                child: const Text("View"),
              ),
              TextButton(
                onPressed: () {
                  deleteSimpleNoteById(simpleNote.id)
                      .then((value) => loadNotes());
                  Navigator.of(context).pop();
                },
                child: const Text("Delete"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HangNoteTimeSelection(simpleNote)));
                },
                child: const Text("Hang"),
              ),
            ],
          ));
        });
    return InkWell(
      onLongPress: showLongPressDialogue,
      child: ExpansionTile(
          title: Text(simpleNote.title),
          subtitle: Text(fullDateDisplay(simpleNote.createdAt)),
          children: [
            ListTile(
                title: Text(simpleNote.content),
                onLongPress: showLongPressDialogue)
          ]),
    );
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
                    deleteTodoNoteById(todoNote.id!)
                        .then((value) => updateNotes());
                    Navigator.of(context).pop();
                  },
                  child: const Text("Delete"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          TodoNoteEdit(updateNotes, note: todoNote),
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
              ],
            ));
          }),
      child: ExpansionTile(title: Text(todoNote.title), children: [
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
          builder: (context, node) => InkWell(
            onLongPress: () => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          deleteTodoNoteById(todoNote.id!);
                          Navigator.of(context).pop();
                        },
                        child: const Text("Delete"),
                      ),
                      TextButton(
                        onPressed: () {
                          node.add(TreeNode(
                              key: node.key + node.children.length.toString()));
                          Navigator.of(context).pop();
                        },
                        child: const Text("Add Child"),
                      ),
                    ],
                  ));
                }),
            child: Card(
              color: todoNoteTreeColorMapper[
                  node.level.clamp(0, todoNoteTreeColorMapper.length - 1)],
              child: ListTile(
                title: TextButton(
                    onPressed: () {
                      // Do something
                    },
                    child: Text(node.data ?? "",
                        style: TextStyle(
                          decoration: treeNodeIsDone(node)
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ))),
              ),
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