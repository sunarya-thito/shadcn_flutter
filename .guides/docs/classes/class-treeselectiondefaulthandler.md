---
title: "Class: TreeSelectionDefaultHandler"
description: "Default handler for tree node selection changes."
---

```dart
/// Default handler for tree node selection changes.
///
/// Manages selection state updates by toggling, adding, or setting
/// selected nodes based on selection mode.
///
/// Example:
/// ```dart
/// final handler = TreeSelectionDefaultHandler(nodes, (updated) {
///   setState(() => nodes = updated);
/// });
/// ```
class TreeSelectionDefaultHandler<T> {
  /// The current list of tree nodes.
  final List<TreeNode<T>> nodes;
  /// Callback when selection state changes.
  final ValueChanged<List<TreeNode<T>>> onChanged;
  /// Creates a [TreeSelectionDefaultHandler].
  TreeSelectionDefaultHandler(this.nodes, this.onChanged);
  /// Handles a selection change event.
  ///
  /// Parameters:
  /// - [selectedNodes]: Nodes to select or deselect
  /// - [multiSelect]: Whether multi-selection is enabled
  /// - [selected]: Whether to select (true) or deselect (false)
  void call(List<TreeNode<T>> selectedNodes, bool multiSelect, bool selected);
}
```
