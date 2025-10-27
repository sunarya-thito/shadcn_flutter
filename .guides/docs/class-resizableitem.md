---
title: "Class: ResizableItem"
description: "Reference for ResizableItem"
---

```dart
class ResizableItem {
  final double min;
  final double max;
  final bool collapsed;
  final double? collapsedSize;
  final bool resizable;
  ResizableItem({required double value, this.min = 0, this.max = double.infinity, this.collapsed = false, this.collapsedSize, this.resizable = true});
  bool get newCollapsed;
  double get newValue;
  double get value;
  String toString();
}
```
