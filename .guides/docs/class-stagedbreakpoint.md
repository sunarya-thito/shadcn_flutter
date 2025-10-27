---
title: "Class: StagedBreakpoint"
description: "Reference for StagedBreakpoint"
---

```dart
class StagedBreakpoint implements StageBreakpoint {
  final List<double> breakpoints;
  const StagedBreakpoint(this.breakpoints);
  const StagedBreakpoint.defaultBreakpoints();
  double getMinWidth(double width);
  double getMaxWidth(double width);
  double get minSize;
  double get maxSize;
}
```
