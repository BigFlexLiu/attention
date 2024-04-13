import 'dart:convert';

import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:intl/intl.dart';

import '../models/todo_note.dart';

DateTime dayOf(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}

bool hasDayPassed(DateTime time) {
  DateTime now = DateTime.now();

  return now.year != time.year ||
      now.month != time.month ||
      now.day != time.day;
}

bool hasMonthPassed(DateTime time) {
  // Check if the year or the month has changed
  DateTime now = DateTime.now();
  bool yearChanged = now.year != now.year;
  bool monthChanged = now.month != now.month;

  // A month boundary has been crossed if either the year or the month has changed
  return yearChanged || monthChanged;
}

String fullDateDisplay(DateTime time) {
  return DateFormat("dd LLLL, yyyy, h:mm a").format(time);
}

extension MyExtension on TreeNode {
  String toJson() {
    final encodedChildren = children.values.map((child) {
      return jsonDecode((child as TreeNode).toJson());
    }).toList();

    final treeNodeJson = {
      "key": key,
      "data": data,
      "children": encodedChildren,
    };

    return jsonEncode(treeNodeJson);
  }
}

TreeNode treeNodeFromJson(String jsonString) {
  Map<String, dynamic> decodedMap = jsonDecode(jsonString);

  TreeNode node = TreeNode(
    key: decodedMap['key'],
    data: decodedMap['data'],
  );
  node.meta = {"isDone": decodedMap['isDone']};

  if (decodedMap['children'] != null) {
    node.addAll(decodedMap['children']
        .map<TreeNode>((childJson) => treeNodeFromJson(jsonEncode(childJson)))
        .toList());
  }

  return node;
}

TreeNode treeNodeFromTodoNote(TodoNote todoNote) {
  TreeNode node = TreeNode(
    key: todoNote.id,
    data: todoNote.title,
  );
  node.meta = {"isDone": todoNote.isDone};

  node.addAll(todoNote.children
      .map<TreeNode>((child) => treeNodeFromTodoNote(child))
      .toList());

  return node;
}

bool treeNodeIsDone(TreeNode node) {
  return node.meta!["isDone"] ||
      (node.parent != null && treeNodeIsDone(node.parent as TreeNode));
}

int convertToInt(dynamic input) {
  if (input is int) {
    return input;
  } else if (input is String) {
    return int.tryParse(input)!;
  }
  throw UnsupportedError("Unsupported type: ${input.runtimeType}");
}
