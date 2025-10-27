---
title: "Class: ConstantBreakpoint"
description: "Reference for ConstantBreakpoint"
---

```dart
class ConstantBreakpoint implements StageBreakpoint {
  final double breakpoint;
  final double minSize;
  final double maxSize;
  const ConstantBreakpoint(this.breakpoint, {this.minSize = 0, this.maxSize = double.infinity});
  double getMinWidth(double width);
  double getMaxWidth(double width);
}
```
