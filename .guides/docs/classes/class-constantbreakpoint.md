---
title: "Class: ConstantBreakpoint"
description: "A breakpoint that uses constant step increments."
---

```dart
/// A breakpoint that uses constant step increments.
///
/// Divides width into uniform steps based on [breakpoint] value. For example,
/// with breakpoint=100, widths 0-99 map to 0, 100-199 map to 100, etc.
class ConstantBreakpoint implements StageBreakpoint {
  /// The step size for width calculations.
  final double breakpoint;
  final double minSize;
  final double maxSize;
  /// Creates a [ConstantBreakpoint].
  const ConstantBreakpoint(this.breakpoint, {this.minSize = 0, this.maxSize = double.infinity});
  double getMinWidth(double width);
  double getMaxWidth(double width);
}
```
