---
title: "Class: SubtractedAxisSize"
description: "Difference of two [AxisSize]s."
---

```dart
/// Difference of two [AxisSize]s.
class SubtractedAxisSize extends AxisSize {
  /// The left operand.
  final AxisSize a;
  /// The right operand.
  final AxisSize b;
  /// Creates a subtracted axis size.
  const SubtractedAxisSize(this.a, this.b);
  double resolve(double available);
}
```
