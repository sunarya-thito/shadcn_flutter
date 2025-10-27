---
title: "Class: TreeSelectionDefaultHandler"
description: "Reference for TreeSelectionDefaultHandler"
---

```dart
class TreeSelectionDefaultHandler<T> {
  final List<TreeNode<T>> nodes;
  final ValueChanged<List<TreeNode<T>>> onChanged;
  TreeSelectionDefaultHandler(this.nodes, this.onChanged);
  void call(List<TreeNode<T>> selectedNodes, bool multiSelect, bool selected);
}
```
