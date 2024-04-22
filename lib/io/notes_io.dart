import 'dart:convert';
import 'dart:io';

import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:attention/models/hanged_note_info.dart';
import 'package:attention/models/todo_note.dart';
import 'package:path_provider/path_provider.dart';

import '../models/simple_note.dart';
import '../util/util.dart';
//////////////////////////////////
/// Notes
//////////////////////////////////

const note_id_counter_file = "note_id_counter.json";
const simple_note_file = "simple_note.json";
const todo_note_file = "todo_note.json";
const hanged_note_info_file = "hanged_note.json";

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

// Id counter
Future<int> readNoteIdCounter() async {
  try {
    final path = await _localPath;
    final file = File('$path/$note_id_counter_file');

    if (!await file.exists()) {
      return 0;
    }

    final String contents = await file.readAsString();

    return int.parse(contents);
  } catch (e) {
    return 0;
  }
}

Future<void> incrementNoteIdCounter() async {
  final path = await _localPath;
  final file = File('$path/$note_id_counter_file');

  if (!await file.exists()) {
    await file.writeAsString("1");
    return;
  }
  final int idCounter = await readNoteIdCounter();

  int id = idCounter + 1;

  file.writeAsString(id.toString());
}

// Simple notes
Future<void> addSimpleNote(String title, String content) async {
  final file = await _localPath;
  List<SimpleNote> notes = await readSimpleNotes();
  notes.add(SimpleNote(
      id: await readNoteIdCounter(),
      title: title,
      content: content,
      createdAt: DateTime.now()));
  await incrementNoteIdCounter();

  File('$file/$simple_note_file').writeAsString(jsonEncode(notes));
}

Future<List<SimpleNote>> readSimpleNotes() async {
  final path = await _localPath;
  final file = File('$path/$simple_note_file');

  if (!await file.exists()) {
    return [];
  }

  final noteString = file.readAsStringSync();
  final List<dynamic> noteJson = jsonDecode(noteString);

  return noteJson.map((json) => SimpleNote.fromJson(json)).toList();
}

Future<void> editSimpleNoteById(int id, String title, String content) async {
  final file = await _localPath;
  final notes = await readSimpleNotes();
  final int targetNoteIdx = notes.indexWhere((element) => element.id == id);
  notes[targetNoteIdx] = SimpleNote(
    id: id,
    title: title,
    content: content,
    createdAt: notes[targetNoteIdx].createdAt,
  );

  File('$file/$simple_note_file').writeAsString(jsonEncode(notes));
}

Future<void> deleteSimpleNoteById(int id) async {
  final file = await _localPath;
  final notes = await readSimpleNotes();
  final filteredNotes = notes.where((note) => note.id != id).toList();

  File('$file/$simple_note_file').writeAsString(jsonEncode(filteredNotes));
}

// Todo notes
Future<void> addTodoNote(TreeNode treeNode) async {
  final file = await _localPath;
  final List<TodoNote> notes = await readTodoNotes();
  final id = await readNoteIdCounter();
  incrementNoteIdCounter();

  TodoNote todoNote = TodoNote.fromTreeNode(treeNode,
      createdAt: DateTime.now(), id: id.toString());

  File('$file/$todo_note_file').writeAsString(jsonEncode(notes + [todoNote]));
}

Future<List<TodoNote>> readTodoNotes() async {
  final path = await _localPath;
  final file = File('$path/$todo_note_file');

  if (!await file.exists()) {
    return [];
  }

  final noteString = file.readAsStringSync();
  final List noteJson = jsonDecode(noteString);

  return noteJson.map((json) => TodoNote.fromJson(json)).toList();
}

Future<void> editTodoNote(TreeNode newNote) async {
  final file = await _localPath;
  final notes = await readTodoNotes();
  final int targetNoteIdx =
      notes.indexWhere((element) => element.id == newNote.key);
  notes[targetNoteIdx] = TodoNote.fromTreeNode(newNote,
      createdAt: notes[targetNoteIdx].createdAt, id: newNote.key);

  File('$file/$todo_note_file').writeAsString(jsonEncode(notes));
}

Future<void> deleteTodoNoteById(String id) async {
  final file = await _localPath;
  final notes = await readTodoNotes();
  final filteredNotes = notes.where((note) => note.id != id).toList();

  File('$file/$todo_note_file').writeAsString(jsonEncode(filteredNotes));
}

// Hanged notes
Future<void> saveHangedNotesInfo(List<HangedNoteInfo> hangedNotes) async {
  final file = await _localPath;
  File('$file/$hanged_note_info_file').writeAsString(jsonEncode(hangedNotes));
}

Future<void> addHangedNote(HangedNoteInfo note) async {
  List<HangedNoteInfo> hangedNotes = await readHangedNotesInfo();

  saveHangedNotesInfo(hangedNotes + [note]);
}

Future<void> editHangedNoteInfoById(int id, DateTime hangUntil) async {
  final file = await _localPath;
  final notes = await readHangedNotesInfo();
  final int targetNoteIdx = notes.indexWhere((element) => element.id == id);
  notes[targetNoteIdx] = notes[targetNoteIdx].copyWith(hangUntil: hangUntil);

  File('$file/$hanged_note_info_file').writeAsString(jsonEncode(notes));
}

Future<List<HangedNoteInfo>> readHangedNotesInfo() async {
  final path = await _localPath;
  final file = File('$path/$hanged_note_info_file');

  if (!await file.exists()) {
    return [];
  }
  final noteString = file.readAsStringSync();
  final List noteJson = jsonDecode(noteString);

  List<HangedNoteInfo> noteInfos = noteJson
      .map<HangedNoteInfo>((json) => HangedNoteInfo.fromJson(json))
      .toList();

  noteInfos
      .removeWhere((element) => element.hangUntil.isBefore(DateTime.now()));
  return noteInfos;
}

Future<List> readHangedNotes() async {
  Future<List<HangedNoteInfo>> hangedNotesInfo = readHangedNotesInfo();
  Future<List<SimpleNote>> simpleNotes = readSimpleNotes();
  Future<List<TodoNote>> todoNotes = readTodoNotes();

  Future.wait([hangedNotesInfo, simpleNotes, todoNotes]);

  final combinedNotes = [...(await simpleNotes), ...(await todoNotes)];
  Map notes = Map.fromIterable(combinedNotes,
      key: (element) => convertToInt(element.id!));

  final List hangedNotes =
      (await hangedNotesInfo).map((e) => notes[e.id]).toList();

  return hangedNotes;
}

Future<void> deleteHangedNoteInfoById(int id) async {
  final file = await _localPath;
  final notes = await readHangedNotesInfo();
  final filteredNotes = notes.where((note) => note.id != id).toList();

  File('$file/$hanged_note_info_file').writeAsString(jsonEncode(filteredNotes));
}

// Resets
Future<void> deleteAllNotes() async {
  final file = await _localPath;
  File('$file/$simple_note_file').writeAsString(jsonEncode([]));
  File('$file/$todo_note_file').writeAsString(jsonEncode([]));
  File('$file/$hanged_note_info_file').writeAsString(jsonEncode([]));
}

Future<void> deleteAllNoteFiles() async {
  final file = await _localPath;
  File('$file/$simple_note_file').delete();
  File('$file/$todo_note_file').delete();
  File('$file/$hanged_note_info_file').delete();
}
