---
title: "Class: MultipliedAxisSize"
description: "An [AxisSize] scaled by a scalar factor."
---

```dart
/// An [AxisSize] scaled by a scalar factor.
class MultipliedAxisSize extends AxisSize {
  /// The operand.
  final AxisSize size;
  /// The scalar factor.
  final double factor;
  /// Creates a multiplied axis size.
  const MultipliedAxisSize(this.size, this.factor);
  double resolve(double available);
}
```
