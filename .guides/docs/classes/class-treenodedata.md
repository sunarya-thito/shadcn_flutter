---
title: "Class: TreeNodeData"
description: "Data container for rendering a tree node."
---

```dart
/// Data container for rendering a tree node.
///
/// Holds all information needed to display a single tree node including
/// its position, expansion state, and visual styling.
class TreeNodeData<T> {
  /// The tree node being rendered.
  final TreeNode<T> node;
  /// The branch line style for this node.
  final BranchLine indentGuide;
  /// Whether this node is currently expanded.
  final bool expanded;
  /// List of depth information from root to this node.
  final List<TreeNodeDepth> depth;
  /// Whether to show the expand/collapse icon.
  final bool expandIcon;
  /// Callback when focus changes for this node.
  final void Function(FocusChangeReason reason)? onFocusChanged;
  /// Visual position of this node within a selection group.
  SelectionPosition? selectionPosition;
  /// Creates a [TreeNodeData] with the specified properties.
  TreeNodeData(this.depth, this.node, this.indentGuide, this.expanded, this.expandIcon, this.onFocusChanged);
}
```
