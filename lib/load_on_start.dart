import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:attention/io/notes_io.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/hanged_note_info.dart';

Future<void> checkFirstLaunchAndUpdate() async {
  final prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  // await deleteAllNotes();
  // await deletePastTasks();
  // await deleteAllNoteFiles();
  // await loadDefaultData();
  // await deleteSettings();
  if (isFirstLaunch) {
    await loadDefaultData();
    await prefs.setBool('isFirstLaunch', false);
  }
}

Future<void> loadDefaultData() async {
  final sampleTodoNote = TreeNode.root(data: "Default Todo Note")
    ..addAll([
      TreeNode(key: "0", data: "Hold to add child or delete")
        ..add(TreeNode(key: "0-0", data: "Press to edit")),
      TreeNode(key: "1", data: "Tap top right to expand all children")
        ..add(TreeNode(key: "1-0", data: "Tap again to collapse all children")),
      TreeNode(key: "2", data: "Tap the plus sign at the bottom to add a task"),
      TreeNode(key: "3", data: "Tap task name at the top to edit it"),
    ]);

  await addSimpleNote("Check out the notes",
      "They help you think. You can hang more notes to help you remember.");
  await addTodoNote(sampleTodoNote);

  final simpleNote = await readSimpleNotes();
  await addHangedNote(HangedNoteInfo(
      id: simpleNote[0].id,
      hangedAt: DateTime.now(),
      hangUntil: DateTime.now().add(const Duration(days: 1))));
}
