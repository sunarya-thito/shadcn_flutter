---
title: "Class: TreeNodeData"
description: "Reference for TreeNodeData"
---

```dart
class TreeNodeData<T> {
  final TreeNode<T> node;
  final BranchLine indentGuide;
  final bool expanded;
  final List<TreeNodeDepth> depth;
  final bool expandIcon;
  final void Function(FocusChangeReason reason)? onFocusChanged;
  SelectionPosition? selectionPosition;
  TreeNodeData(this.depth, this.node, this.indentGuide, this.expanded, this.expandIcon, this.onFocusChanged);
}
```
