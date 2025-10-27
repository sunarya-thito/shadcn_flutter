---
title: "Class: TreeItemExpandDefaultHandler"
description: "Reference for TreeItemExpandDefaultHandler"
---

```dart
class TreeItemExpandDefaultHandler<T> {
  final List<TreeNode<T>> nodes;
  final ValueChanged<List<TreeNode<T>>> onChanged;
  final TreeNode<T> target;
  TreeItemExpandDefaultHandler(this.nodes, this.target, this.onChanged);
  void call(bool expanded);
}
```
