---
title: "Class: Resizer"
description: "Reference for Resizer"
---

```dart
class Resizer {
  final List<ResizableItem> items;
  final double collapseRatio;
  final double expandRatio;
  Resizer(this.items, {this.collapseRatio = 0.5, this.expandRatio = 0.5});
  bool attemptExpand(int index, int direction, double delta);
  bool attemptCollapse(int index, int direction);
  bool attemptExpandCollapsed(int index, int direction);
  void dragDivider(int index, double delta);
  void reset();
}
```
