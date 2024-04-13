import 'package:flutter/material.dart';

class QANote extends StatelessWidget {
  const QANote({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QA Note"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: "New note",
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("New note"),
                      content: const TextField(
                        decoration:
                            InputDecoration(hintText: "Enter question here"),
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
                            Navigator.of(context).pop();
                          },
                          child: const Text("Save"),
                        ),
                      ],
                    );
                  });
            },
          ),
          IconButton(
            icon: const Icon(Icons.recycling),
            tooltip: "Reuse question",
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          const TextField(
            decoration: InputDecoration(
              hintText: "Enter your reflection here",
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
            maxLines: null,
          ),
          ListTile(
            title: const Text('Reflection 1'),
            subtitle: const Text('Description 1'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Reflection 2'),
            subtitle: const Text('Description 2'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Reflection 3'),
            subtitle: const Text('Description 3'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
