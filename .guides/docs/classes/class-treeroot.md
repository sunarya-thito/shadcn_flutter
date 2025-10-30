---
title: "Class: TreeRoot"
description: "A special tree node that serves as an invisible root container."
---

```dart
/// A special tree node that serves as an invisible root container.
///
/// TreeRoot represents the invisible root of a tree structure that contains
/// other tree nodes but doesn't appear in the visual tree. It's always considered
/// expanded and never selected, serving purely as a container for organizing
/// multiple top-level tree items.
///
/// This is useful when you need to group multiple tree items under a common
/// parent without showing that parent in the tree view. All children of a
/// TreeRoot appear at the top level of the tree.
///
/// TreeRoot maintains immutability like other tree nodes, but state update
/// operations (expanded/selected) have no effect since these properties are
/// fixed by design.
///
/// Example:
/// ```dart
/// TreeRoot<String> root = TreeRoot(
///   children: [
///     TreeItem(data: 'First Section'),
///     TreeItem(data: 'Second Section'),
///     TreeItem(data: 'Third Section'),
///   ],
/// );
///
/// // Root is always expanded and never selected
/// print(root.expanded); // true
/// print(root.selected); // false
/// ```
class TreeRoot<T> extends TreeNode<T> {
  /// List of child nodes contained in this root.
  ///
  /// Type: `List<TreeNode<T>>`. These children appear as top-level items
  /// in the tree view since the root itself is invisible.
  final List<TreeNode<T>> children;
  /// Always returns true since root containers are conceptually always expanded.
  ///
  /// Returns: `bool`. TreeRoot is always expanded to show its children.
  bool get expanded;
  /// Always returns false since root containers cannot be selected.
  ///
  /// Returns: `bool`. TreeRoot can never be selected in tree operations.
  bool get selected;
  /// Creates a [TreeRoot] container with the specified children.
  ///
  /// Constructs an invisible root node that serves as a container for
  /// multiple top-level tree items.
  ///
  /// Parameters:
  /// - [children] (`List<TreeNode<T>>`, required): Child nodes to contain
  ///
  /// Example:
  /// ```dart
  /// TreeRoot<String> root = TreeRoot(
  ///   children: [
  ///     TreeItem(data: 'Item 1'),
  ///     TreeItem(data: 'Item 2'),
  ///     TreeItem(data: 'Item 3'),
  ///   ],
  /// );
  /// ```
  TreeRoot({required this.children});
  TreeRoot<T> updateState({bool? expanded, bool? selected});
  TreeRoot<T> updateChildren(List<TreeNode<T>> children);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
