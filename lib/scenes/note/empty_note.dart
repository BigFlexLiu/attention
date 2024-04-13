import 'package:attention/io/notes_io.dart';
import 'package:flutter/material.dart';

import '../../models/simple_note.dart';

class EmptyNote extends StatefulWidget {
  EmptyNote(this.onNoteSaved, {this.note, super.key});
  VoidCallback onNoteSaved;
  SimpleNote? note;

  @override
  State<EmptyNote> createState() => _EmptyNoteState();
}

class _EmptyNoteState extends State<EmptyNote> with WidgetsBindingObserver {
  final TextEditingController _titleEdittingController =
      TextEditingController();
  final TextEditingController _noteEdittingController = TextEditingController();

  String title = "";
  String content = "";

  @override
  void initState() {
    if (widget.note != null) {
      _titleEdittingController.text = widget.note!.title;
      _noteEdittingController.text = widget.note!.content;
    }
    super.initState();
  }

  void updateNote() async {
    if (title == "" && content == "") return;
    if (widget.note == null) {
      await addSimpleNote(
          _titleEdittingController.text, _noteEdittingController.text);
    } else {
      await editSimpleNoteById(widget.note!.id, _titleEdittingController.text,
          _noteEdittingController.text);
    }
    widget.onNoteSaved();
  }

  @override
  void dispose() {
    updateNote();

    _titleEdittingController.dispose();
    _noteEdittingController.dispose();
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
                      title: const Text("Change note title"),
                      content: TextField(
                        controller: _titleEdittingController,
                        decoration:
                            const InputDecoration(hintText: "Note title"),
                        onChanged: (value) => setState(() {
                          title = value;
                        }),
                      ),
                    )),
            child: Row(
              children: [
                Text(_titleEdittingController.text.isEmpty
                    ? "Untitled"
                    : _titleEdittingController.text),
              ],
            ),
          ),
        ),
        body: TextField(
          controller: _noteEdittingController,
          decoration: const InputDecoration(
            hintText: "Enter your note here",
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(16),
          ),
          maxLines: null,
          onChanged: (value) => setState(() {
            content = value;
          }),
        ));
  }
}