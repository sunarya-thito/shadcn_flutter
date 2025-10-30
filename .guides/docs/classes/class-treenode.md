---
title: "Class: TreeNode"
description: "Abstract base class representing a node in a tree structure."
---

```dart
/// Abstract base class representing a node in a tree structure.
///
/// TreeNode defines the interface for all nodes in the tree hierarchy, providing
/// access to children, expansion state, and selection state. It supports immutable
/// updates through copy methods that return new instances with modified state.
///
/// The generic type parameter [T] represents the data type stored in tree items.
/// TreeNode is implemented by [TreeItem] for data-bearing nodes and [TreeRoot]
/// for the invisible root container.
///
/// Key operations include state updates for expansion and selection, child
/// manipulation, and leaf node detection. All state changes return new instances
/// to maintain immutability.
///
/// Example:
/// ```dart
/// TreeNode<String> node = TreeItem(
///   data: 'parent',
///   children: [TreeItem(data: 'child1'), TreeItem(data: 'child2')],
/// );
///
/// // Expand the node
/// TreeNode<String> expanded = node.updateState(expanded: true);
///
/// // Check if it's a leaf
/// bool isLeaf = node.leaf; // false, has children
/// ```
abstract class TreeNode<T> {
  /// List of child nodes belonging to this node.
  ///
  /// Returns: `List<TreeNode<T>>`. An empty list indicates a leaf node with no children.
  /// The list defines the hierarchical structure beneath this node.
  List<TreeNode<T>> get children;
  /// Whether this node is currently expanded to show its children.
  ///
  /// Returns: `bool`. True when the node is expanded and children are visible,
  /// false when collapsed. Root nodes are always considered expanded.
  bool get expanded;
  /// Whether this node is currently selected.
  ///
  /// Returns: `bool`. True when the node is part of the current selection,
  /// false otherwise. Selection affects visual appearance and behavior.
  bool get selected;
  /// Whether this node is a leaf (has no children).
  ///
  /// Returns: `bool`. True when [children] is empty, false when the node has child nodes.
  /// Convenient property for determining if a node can be expanded.
  bool get leaf;
  /// Creates a new instance with updated expansion and/or selection state.
  ///
  /// Returns a new TreeNode instance with the specified state changes while
  /// preserving all other properties. This maintains immutability of tree structures.
  ///
  /// Parameters:
  /// - [expanded] (bool?, optional): New expansion state, or null to keep current
  /// - [selected] (bool?, optional): New selection state, or null to keep current
  ///
  /// Returns: A new `TreeNode<T>` instance with updated state
  ///
  /// Example:
  /// ```dart
  /// TreeNode<String> expandedNode = node.updateState(expanded: true);
  /// TreeNode<String> selectedNode = node.updateState(selected: true);
  /// TreeNode<String> both = node.updateState(expanded: true, selected: true);
  /// ```
  TreeNode<T> updateState({bool? expanded, bool? selected});
  /// Creates a new instance with updated children list.
  ///
  /// Returns a new TreeNode instance with the specified children while preserving
  /// all other properties including state. Used for structural modifications.
  ///
  /// Parameters:
  /// - [children] (`List<TreeNode<T>>`): New list of child nodes
  ///
  /// Returns: A new `TreeNode<T>` instance with updated children
  ///
  /// Example:
  /// ```dart
  /// List<TreeNode<String>> newChildren = [TreeItem(data: 'new_child')];
  /// TreeNode<String> updated = node.updateChildren(newChildren);
  /// ```
  TreeNode<T> updateChildren(List<TreeNode<T>> children);
}
```
