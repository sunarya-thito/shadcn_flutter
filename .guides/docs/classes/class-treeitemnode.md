---
title: "Class: TreeItemNode"
description: "A concrete tree node implementation that holds data and state.   TreeItemNode represents a data-bearing node in the tree structure with support  for hierarchical organization, expansion/collapse state, and selection state.  It implements the immutable pattern where state changes return new instances.   Each TreeItemNode contains user data of type [T], a list of child nodes, and  boolean flags for expansion and selection state. The class provides equality  comparison based on all properties and implements proper hash codes.   TreeItemNode supports deep hierarchies through its children list, which can  contain other TreeItemNode instances or TreeRootNode containers. The expansion state  controls visibility of children in tree views.   Example:  ```dart  // Create a simple item  TreeItemNode<String> item = TreeItemNode(    data: 'Document',    expanded: true,    selected: false,    children: [      TreeItemNode(data: 'Chapter 1'),      TreeItemNode(data: 'Chapter 2'),    ],  );   // Update its state  TreeItemNode<String> selected = item.updateState(selected: true);  ```"
---

```dart
/// A concrete tree node implementation that holds data and state.
///
/// TreeItemNode represents a data-bearing node in the tree structure with support
/// for hierarchical organization, expansion/collapse state, and selection state.
/// It implements the immutable pattern where state changes return new instances.
///
/// Each TreeItemNode contains user data of type [T], a list of child nodes, and
/// boolean flags for expansion and selection state. The class provides equality
/// comparison based on all properties and implements proper hash codes.
///
/// TreeItemNode supports deep hierarchies through its children list, which can
/// contain other TreeItemNode instances or TreeRootNode containers. The expansion state
/// controls visibility of children in tree views.
///
/// Example:
/// ```dart
/// // Create a simple item
/// TreeItemNode<String> item = TreeItemNode(
///   data: 'Document',
///   expanded: true,
///   selected: false,
///   children: [
///     TreeItemNode(data: 'Chapter 1'),
///     TreeItemNode(data: 'Chapter 2'),
///   ],
/// );
///
/// // Update its state
/// TreeItemNode<String> selected = item.updateState(selected: true);
/// ```
class TreeItemNode<T> extends TreeNode<T> {
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
  /// Creates a [TreeItemNode] with the specified data and configuration.
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
  /// TreeItemNode<String> leaf = TreeItemNode(data: 'Leaf Node');
  ///
  /// // Parent with children
  /// TreeItemNode<String> parent = TreeItemNode(
  ///   data: 'Parent Node',
  ///   expanded: true,
  ///   children: [
  ///     TreeItemNode(data: 'Child 1'),
  ///     TreeItemNode(data: 'Child 2'),
  ///   ],
  /// );
  /// ```
  TreeItemNode({required this.data, this.children = const [], this.expanded = false, this.selected = false});
  TreeItemNode<T> updateState({bool? expanded, bool? selected});
  TreeItemNode<T> updateChildren(List<TreeNode<T>> children);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
