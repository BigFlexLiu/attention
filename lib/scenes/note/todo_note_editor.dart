import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:animated_tree_view/tree_view/widgets/expansion_indicator.dart';
import 'package:animated_tree_view/tree_view/widgets/indent.dart';
import 'package:attention/io/notes_io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/todo_note.dart';
import '../../theme/theme.dart';
import '../../util/util.dart';

const showSnackBar = false;
const expandChildrenOnReady = true;

class TodoNoteEditor extends StatefulWidget {
  TodoNoteEditor(this.saveNote, {this.note, Key? key}) : super(key: key);
  VoidCallback saveNote;
  TodoNote? note;

  @override
  TodoNoteEditorState createState() => TodoNoteEditorState();
}

class TodoNoteEditorState extends State<TodoNoteEditor>
    with WidgetsBindingObserver {
  final TextEditingController _textEdittingController = TextEditingController();
  final TextEditingController _TaskTitleController = TextEditingController();
  TreeNode note = TreeNode.root();

  String _taskTitle = "Default Title";

  @override
  void initState() {
    if (widget.note != null) {
      note = treeNodeFromTodoNote(widget.note!);
    }
    super.initState();
  }

  void updateNote() async {
    if (note.data == null && note.children.isEmpty) return;
    if (widget.note == null) {
      await addTodoNote(note);
    } else {
      await editTodoNote(note);
    }
    widget.saveNote();
  }

  @override
  void dispose() {
    updateNote();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      updateNote();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
            onTap: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text("Add Task"),
                      content: TextField(
                        controller: _TaskTitleController,
                        decoration:
                            const InputDecoration(hintText: "Task Name"),
                        onChanged: (value) {
                          setState(() {
                            _taskTitle = value;
                            note.data = value;
                          });
                        },
                      ),
                    )),
            child: Text(_taskTitle)),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () =>
                  note.add(TreeNode(key: "${note.children.length}"))),
        ],
      ),
      body: TreeView.simple(
        shrinkWrap: true,
        tree: note,
        showRootNode: false,
        expansionIndicatorBuilder: (context, node) =>
            ChevronIndicator.rightDown(
          tree: node,
          color: Colors.blue[700],
          padding: const EdgeInsets.all(8),
        ),
        indentation: const Indentation(style: IndentStyle.squareJoint),
        onItemTap: (item) {
          if (kDebugMode) print("Item tapped: ${item.key}");

          if (showSnackBar) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Item tapped: ${item.key}"),
                duration: const Duration(milliseconds: 750),
              ),
            );
          }
        },
        onTreeReady: (controller) {
          if (expandChildrenOnReady) controller.expandAllChildren(note);
        },
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
                        node.parent?.remove(node);
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
                    _textEdittingController.text = node.data ?? "";

                    showDialog(
                        context: context,
                        builder: (context) {
                          _textEdittingController.text = node.data ?? "";
                          return AlertDialog(
                            title: const Text("Edit task"),
                            content: TextField(
                              controller: _textEdittingController,
                              decoration: const InputDecoration(
                                  hintText: "Enter task title"),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    node.data = _textEdittingController.text;
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Save"),
                              ),
                            ],
                          );
                        });
                  },
                  child: Text(node.data ?? "")),
            ),
          ),
        ),
      ),
    );
  }
}
