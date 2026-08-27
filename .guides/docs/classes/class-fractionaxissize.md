---
title: "Class: FractionAxisSize"
description: "An [AxisSize] that is a fraction of the available extent."
---

```dart
/// An [AxisSize] that is a fraction of the available extent.
class FractionAxisSize extends AxisSize {
  /// The fraction (0..1) of the available extent.
  final double fraction;
  /// Creates a fractional axis size.
  const FractionAxisSize(this.fraction);
  double resolve(double available);
}
```
