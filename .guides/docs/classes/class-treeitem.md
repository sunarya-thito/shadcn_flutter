---
title: "Class: TreeItem"
description: "A concrete tree node implementation that holds data and state."
---

```dart
/// A concrete tree node implementation that holds data and state.
///
/// TreeItem represents a data-bearing node in the tree structure with support
/// for hierarchical organization, expansion/collapse state, and selection state.
/// It implements the immutable pattern where state changes return new instances.
///
/// Each TreeItem contains user data of type [T], a list of child nodes, and
/// boolean flags for expansion and selection state. The class provides equality
/// comparison based on all properties and implements proper hash codes.
///
/// TreeItem supports deep hierarchies through its children list, which can
/// contain other TreeItem instances or TreeRoot containers. The expansion state
/// controls visibility of children in tree views.
///
/// Example:
/// ```dart
/// // Create a simple item
/// TreeItem<String> item = TreeItem(
///   data: 'Document',
///   expanded: true,
///   selected: false,
///   children: [
///     TreeItem(data: 'Chapter 1'),
///     TreeItem(data: 'Chapter 2'),
///   ],
/// );
///
/// // Update its state
/// TreeItem<String> selected = item.updateState(selected: true);
/// ```
class TreeItem<T> extends TreeNode<T> {
  /// The data value stored in this tree item.
  ///
  /// Type: `T`. This is the actual content that the tree item represents,
  /// such as a string, object, or any other data type.
  final T data;
  /// List of child nodes beneath this item in the tree hierarchy.
  ///
  /// Type: `List<TreeNode<T>>`. Empty list indicates a leaf node. Children
  /// are only visible when this item's [expanded] state is true.
  final List<TreeNode<T>> children;
  /// Whether this item is currently expanded to show its children.
  ///
  /// Type: `bool`. When true, child nodes are visible in tree views.
  /// When false, children are hidden but still present in the data structure.
  final bool expanded;
  /// Whether this item is currently selected.
  ///
  /// Type: `bool`. Selection affects visual appearance and can trigger
  /// recursive selection of children depending on tree configuration.
  final bool selected;
  /// Creates a [TreeItem] with the specified data and configuration.
  ///
  /// Constructs a tree item node with user data and optional children,
  /// expansion state, and selection state.
  ///
  /// Parameters:
  /// - [data] (T, required): The data value to store in this tree item
  /// - [children] (`List<TreeNode<T>>`, default: []): Child nodes list
  /// - [expanded] (bool, default: false): Initial expansion state
  /// - [selected] (bool, default: false): Initial selection state
  ///
  /// Example:
  /// ```dart
  /// // Simple leaf item
  /// TreeItem<String> leaf = TreeItem(data: 'Leaf Node');
  ///
  /// // Parent with children
  /// TreeItem<String> parent = TreeItem(
  ///   data: 'Parent Node',
  ///   expanded: true,
  ///   children: [
  ///     TreeItem(data: 'Child 1'),
  ///     TreeItem(data: 'Child 2'),
  ///   ],
  /// );
  /// ```
  TreeItem({required this.data, this.children = const [], this.expanded = false, this.selected = false});
  TreeItem<T> updateState({bool? expanded, bool? selected});
  TreeItem<T> updateChildren(List<TreeNode<T>> children);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
