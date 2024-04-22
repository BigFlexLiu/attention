import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:animated_tree_view/tree_view/widgets/expansion_indicator.dart';
import 'package:animated_tree_view/tree_view/widgets/indent.dart';
import 'package:attention/io/notes_io.dart';
import 'package:attention/scenes/note/hang_note_time_selection.dart';
import 'package:flutter/material.dart';

import '../../models/todo_note.dart';
import '../../theme/theme.dart';
import '../../util/util.dart';

const showSnackBar = false;
const expandChildrenOnReady = true;

class TodoNoteView extends StatefulWidget {
  TodoNoteView(this.saveNote, this.note, {Key? key}) : super(key: key);
  VoidCallback saveNote;
  TodoNote note;

  @override
  TodoNoteViewState createState() => TodoNoteViewState();
}

class TodoNoteViewState extends State<TodoNoteView>
    with WidgetsBindingObserver {
  late TreeNode treeNode;

  @override
  void initState() {
    treeNode = treeNodeFromTodoNote(widget.note);
    super.initState();
  }

  void updateNote() async {
    await editTodoNote(treeNode);
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
          title: Text(treeNode.data),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HangNoteTimeSelection(widget.note)));
                },
                icon: const Icon(Icons.photo_library),
                tooltip: "Hang it"),
          ],
        ),
        body: TodoNoteTree(treeNode));
  }
}

class TodoNoteTree extends StatefulWidget {
  TodoNoteTree(this.treeNode, {super.key});
  TreeNode treeNode;

  @override
  State<TodoNoteTree> createState() => _TodoNoteTreeState();
}

class _TodoNoteTreeState extends State<TodoNoteTree> {
  @override
  Widget build(BuildContext context) {
    return TreeView.simple(
        shrinkWrap: true,
        tree: widget.treeNode,
        showRootNode: false,
        expansionIndicatorBuilder: (context, node) =>
            ChevronIndicator.rightDown(
              tree: node,
              color: Colors.blue[700],
              padding: const EdgeInsets.all(8),
            ),
        indentation: const Indentation(style: IndentStyle.squareJoint),
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
                                key: node.key +
                                    node.children.length.toString()));
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
                        setState(() {
                          node.meta!["isDone"] =
                              !(node.meta!["isDone"] ?? false);
                        });
                      },
                      child: Text(node.data as String,
                          style: TextStyle(
                            decoration: treeNodeIsDone(node)
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ))),
                ),
              ),
            ));
  }
}
