---
title: "Class: StageBreakpoint"
description: "Reference for StageBreakpoint"
---

```dart
abstract class StageBreakpoint {
  factory StageBreakpoint.constant(double breakpoint, {double minSize = 0, double maxSize = double.infinity});
  factory StageBreakpoint.staged(List<double> breakpoints);
  static const StageBreakpoint defaultBreakpoints = StagedBreakpoint.defaultBreakpoints();
  double getMinWidth(double width);
  double getMaxWidth(double width);
  double get minSize;
  double get maxSize;
}
```
