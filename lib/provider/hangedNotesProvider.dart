import 'package:attention/util/util.dart';
import 'package:flutter/cupertino.dart';

import '../io/notes_io.dart';
import '../models/hanged_note_info.dart';

class HangedNotesProvider extends ChangeNotifier {
  List<HangedNoteInfo> _hangedNotesInfo = [];
  Map notes = {};

  List<HangedNoteInfo> get hangedNotesInfo => _hangedNotesInfo;
  Map get hangedNotes => notes;

  dynamic getHangedNoteById(id) => notes[id];

  void hangNote(note, hangUntil) async {
    // Update if exists
    for (var hangedNote in _hangedNotesInfo) {
      if (hangedNote.id == note.id) {
        editHangedNoteInfoById(note.id, hangUntil);
        pullHangedNotes();
        return;
      }
    }

    // Add if not exists
    await addHangedNote(HangedNoteInfo(
        id: convertToInt(note.id),
        hangedAt: DateTime.now(),
        hangUntil: hangUntil));
    pullHangedNotes();
  }

  void editTodoNoteById(todoNote) async {
    await editTodoNote(todoNote);
    pullHangedNotes();
  }

  Future<void> pullHangedNotes() async {
    _hangedNotesInfo = await readHangedNotesInfo();
    final noteList = await readHangedNotes();
    notes = Map.fromIterable(noteList,
        key: (element) =>
            element.id is int ? element.id : int.parse(element.id!));

    notifyListeners();
  }
}
