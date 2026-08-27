---
title: "Class: AdditiveAxisSize"
description: "Sum of two [AxisSize]s."
---

```dart
/// Sum of two [AxisSize]s.
class AdditiveAxisSize extends AxisSize {
  /// The left operand.
  final AxisSize a;
  /// The right operand.
  final AxisSize b;
  /// Creates an additive axis size.
  const AdditiveAxisSize(this.a, this.b);
  double resolve(double available);
}
```
