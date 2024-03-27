import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/substep.dart';
import '../../provider/task_provider.dart';

class TaskBreakdown extends StatefulWidget {
  const TaskBreakdown({super.key});

  @override
  State<TaskBreakdown> createState() => _TaskBreakdownState();
}

class _TaskBreakdownState extends State<TaskBreakdown> {
  final List<Substep> _items = [
    const Substep(title: "Item 1", isCompleted: false),
    const Substep(title: "Item 2", isCompleted: false),
    const Substep(title: "Item 3", isCompleted: false),
  ];
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  hintText: 'Task Name',
                ),
              ),
            ),
            Center(
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    _items.add(Substep(
                        title: _textController.text, isCompleted: false));
                    Provider.of<TaskProvider>(context, listen: false)
                        .setTaskSteps(_items);
                    _textController.clear();
                  });
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: ReorderableListView(
            children: _items
                .map((item) => ListTile(
                      tileColor: _items.indexOf(item).isOdd
                          ? oddItemColor
                          : evenItemColor,
                      key: Key(item.title),
                      title: Text(item.title),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            _items.remove(item);
                            Provider.of<TaskProvider>(context, listen: false)
                                .setTaskSteps(_items);
                          });
                        },
                      ),
                      // Add logic here for indenting sub-items or showing them differently
                    ))
                .toList(),
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                final Substep item = _items.removeAt(oldIndex);
                _items.insert(newIndex, item);
                Provider.of<TaskProvider>(context, listen: false)
                    .setTaskSteps(_items);
              });
            },
          ),
        ),
      ],
    );
  }
}

class ReorderableExample extends StatefulWidget {
  const ReorderableExample(this.items, {super.key});
  final List<String> items;

  @override
  State<ReorderableExample> createState() => _ReorderableListViewExampleState();
}

class _ReorderableListViewExampleState extends State<ReorderableExample> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return ReorderableListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: <Widget>[
        for (int index = 0; index < widget.items.length; index += 1)
          ListTile(
            key: Key('$index'),
            tileColor: index.isOdd ? oddItemColor : evenItemColor,
            title: Text(widget.items[index]),
            trailing: IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    widget.items.removeAt(index);
                  });
                }),
          ),
      ],
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final String item = widget.items.removeAt(oldIndex);
          widget.items.insert(newIndex, item);
        });
      },
    );
  }
}
