---
title: "Class: TreeNodeDepth"
description: "Represents depth information for a tree node."
---

```dart
/// Represents depth information for a tree node.
///
/// Contains index and count information used for rendering
/// indent guides and branch lines.
class TreeNodeDepth {
  /// Index of this child among its siblings (0-based).
  final int childIndex;
  /// Total number of children at this level.
  final int childCount;
  /// Creates a [TreeNodeDepth] with the specified index and count.
  TreeNodeDepth(this.childIndex, this.childCount);
}
```
