import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'todo_note.freezed.dart';
part 'todo_note.g.dart';

@freezed
abstract class TodoNote with _$TodoNote {
  const factory TodoNote({
    required String? id,
    required String title,
    required List<TodoNote> children,
    required DateTime? createdAt,
    required bool isDone,
  }) = _TodoNote;

  factory TodoNote.fromJson(Map<String, dynamic> json) =>
      _$TodoNoteFromJson(json);

  factory TodoNote.fromTreeNode(TreeNode treeNode,
      {DateTime? createdAt, String? id}) {
    return TodoNote(
      id: id ?? treeNode.key,
      title: treeNode.data ?? "",
      children: treeNode.children.values
          .map((child) => TodoNote.fromTreeNode(child as TreeNode))
          .toList(),
      isDone: (treeNode.meta?.containsKey("isDone") ?? false)
          ? treeNode.meta!["isDone"]
          : false,
      createdAt: createdAt,
    );
  }
}
