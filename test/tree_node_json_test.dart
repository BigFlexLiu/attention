import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:attention/util/util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TreeNode Serialization and Deserialization', () {
    test('Serializes and deserializes a simple TreeNode without children', () {
      final treeNode = TreeNode(key: 'rootKey', data: 'rootData');
      final json = treeNode.toJson();
      final deserializedNode = treeNodeFromJson(json);

      expect(deserializedNode.key, treeNode.key);
      expect(deserializedNode.data, treeNode.data);
      expect(deserializedNode.children.isEmpty, isTrue);
    });

    test('Serializes and deserializes a TreeNode with nested children', () {
      final rootNode = TreeNode(key: 'rootKey', data: 'rootData');
      final childNode = TreeNode(key: 'childKey', data: 'childData');

      rootNode.add(childNode);

      final json = rootNode.toJson();
      final deserializedRootNode = treeNodeFromJson(json);

      expect(deserializedRootNode.key, rootNode.key);
      expect(deserializedRootNode.data, rootNode.data);
      expect(deserializedRootNode.children.isNotEmpty, isTrue);
      expect(deserializedRootNode.children.containsKey(childNode.key), isTrue);
      expect(deserializedRootNode.children[childNode.key]!.key, childNode.key);
      expect((deserializedRootNode.children[childNode.key]! as TreeNode).data,
          childNode.data);
    });

    test('Handles empty TreeNode gracefully', () {
      final treeNode = TreeNode();
      final json = treeNode.toJson();
      final deserializedNode = treeNodeFromJson(json);

      expect(deserializedNode.key, treeNode.key);
      expect(deserializedNode.data, isNull);
      expect(deserializedNode.children.isEmpty, isTrue);
    });

    test('Serializes and deserializes a complex TreeNode hierarchy', () {
      // Creating the root node
      final rootNode = TreeNode(key: 'rootKey', data: 'rootData');

      // Creating the first child of the root
      final childNode1 = TreeNode(key: 'childKey1', data: 'childData1');

      // Creating the second child of the root which will also have its own child
      final childNode2 = TreeNode(key: 'childKey2', data: 'childData2');

      // Creating the child of the second child node
      final grandchildNode1 =
          TreeNode(key: 'grandchildKey1', data: 'grandchildData1');

      // Assembling the hierarchy
      rootNode.add(childNode1);
      rootNode.add(childNode2);
      childNode2.add(grandchildNode1);

      // Serializing the root node to JSON
      final json = rootNode.toJson();

      // Deserializing the JSON back into a TreeNode structure
      final deserializedRootNode = treeNodeFromJson(json);

      // Verifying the root properties
      expect(deserializedRootNode.key, rootNode.key);
      expect(deserializedRootNode.data, rootNode.data);
      expect(deserializedRootNode.children.length, 2);

      // Verifying the first child node
      expect(deserializedRootNode.children.containsKey(childNode1.key), isTrue);
      expect((deserializedRootNode.children[childNode1.key]! as TreeNode).data,
          childNode1.data);

      // Verifying the second child node and its child
      expect(deserializedRootNode.children.containsKey(childNode2.key), isTrue);
      final deserializedChildNode2 =
          deserializedRootNode.children[childNode2.key] as TreeNode;
      expect(deserializedChildNode2.data, childNode2.data);
      expect(deserializedChildNode2.children.length, 1);
      expect(deserializedChildNode2.children.containsKey(grandchildNode1.key),
          isTrue);
      expect(
          (deserializedChildNode2.children[grandchildNode1.key]! as TreeNode)
              .data,
          grandchildNode1.data);
    });
  });
}
