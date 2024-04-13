import 'package:attention/scenes/note/empty_note.dart';
import 'package:attention/scenes/note/todo_note_edit.dart';
import 'package:flutter/material.dart';

class MakeNote extends StatelessWidget {
  MakeNote(this.onNoteChanged, {Key? key}) : super(key: key);
  VoidCallback onNoteChanged;

  final oddColor = Colors.grey[300];
  final evenColor = Colors.grey[100];

  @override
  Widget build(BuildContext context) {
    final List<Template> templates = [
      Template("Empty Note", const Icon(Icons.add), EmptyNote(onNoteChanged)),
      Template(
          "Todo Note", const Icon(Icons.list), TodoNoteEdit(onNoteChanged)),
      // Template("Reflection Note", Icon(Icons.psychology), QANote()),
      // Template("Project Tree", Icon(Icons.park), ProjectTree()),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Templates")),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          child: ListView.builder(
            itemCount: templates.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => templates[index].page,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    color: index.isEven ? evenColor : oddColor,
                    child: Row(
                      children: [
                        Hero(
                          tag: index,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: templates[index].icon,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Text(
                          templates[index].title,
                          style: Theme.of(context).textTheme.headlineMedium,
                        )),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Template {
  final String title;
  final Icon icon;
  final Widget page;

  Template(this.title, this.icon, this.page);
}
