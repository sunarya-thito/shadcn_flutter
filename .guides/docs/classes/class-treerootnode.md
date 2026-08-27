---
title: "Class: TreeRootNode"
description: "A special tree node that serves as an invisible root container.   TreeRootNode represents the invisible root of a tree structure that contains  other tree nodes but doesn't appear in the visual tree. It's always considered  expanded and never selected, serving purely as a container for organizing  multiple top-level tree items.   This is useful when you need to group multiple tree items under a common  parent without showing that parent in the tree view. All children of a  TreeRootNode appear at the top level of the tree.   TreeRootNode maintains immutability like other tree nodes, but state update  operations (expanded/selected) have no effect since these properties are  fixed by design.   Example:  ```dart  TreeRootNode<String> root = TreeRootNode(    children: [      TreeItemNode(data: 'First Section'),      TreeItemNode(data: 'Second Section'),      TreeItemNode(data: 'Third Section'),    ],  );   // Root is always expanded and never selected  print(root.expanded); // true  print(root.selected); // false  ```"
---

```dart
/// A special tree node that serves as an invisible root container.
///
/// TreeRootNode represents the invisible root of a tree structure that contains
/// other tree nodes but doesn't appear in the visual tree. It's always considered
/// expanded and never selected, serving purely as a container for organizing
/// multiple top-level tree items.
///
/// This is useful when you need to group multiple tree items under a common
/// parent without showing that parent in the tree view. All children of a
/// TreeRootNode appear at the top level of the tree.
///
/// TreeRootNode maintains immutability like other tree nodes, but state update
/// operations (expanded/selected) have no effect since these properties are
/// fixed by design.
///
/// Example:
/// ```dart
/// TreeRootNode<String> root = TreeRootNode(
///   children: [
///     TreeItemNode(data: 'First Section'),
///     TreeItemNode(data: 'Second Section'),
///     TreeItemNode(data: 'Third Section'),
///   ],
/// );
///
/// // Root is always expanded and never selected
/// print(root.expanded); // true
/// print(root.selected); // false
/// ```
class TreeRootNode<T> extends TreeNode<T> {
  /// List of child nodes contained in this root.
  ///
  /// Type: `List<TreeNode<T>>`. These children appear as top-level items
  /// in the tree view since the root itself is invisible.
  final List<TreeNode<T>> children;
  /// Always returns true since root containers are conceptually always expanded.
  ///
  /// Returns: `bool`. TreeRootNode is always expanded to show its children.
  bool get expanded;
  /// Always returns false since root containers cannot be selected.
  ///
  /// Returns: `bool`. TreeRootNode can never be selected in tree operations.
  bool get selected;
  /// Creates a [TreeRootNode] container with the specified children.
  ///
  /// Constructs an invisible root node that serves as a container for
  /// multiple top-level tree items.
  ///
  /// Parameters:
  /// - [children] (`List<TreeNode<T>>`, required): Child nodes to contain
  ///
  /// Example:
  /// ```dart
  /// TreeRootNode<String> root = TreeRootNode(
  ///   children: [
  ///     TreeItemNode(data: 'Item 1'),
  ///     TreeItemNode(data: 'Item 2'),
  ///     TreeItemNode(data: 'Item 3'),
  ///   ],
  /// );
  /// ```
  TreeRootNode({required this.children});
  TreeRootNode<T> updateState({bool? expanded, bool? selected});
  TreeRootNode<T> updateChildren(List<TreeNode<T>> children);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
