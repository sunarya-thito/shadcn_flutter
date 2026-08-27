---
title: "Class: AxisSize"
description: "A cross-axis size for a drawer/sheet container, resolved against the  available cross-axis extent. Used by [DrawerContainer]/[SheetContainer] to  size the sheet so it doesn't stretch edge-to-edge.   Supports arithmetic: `AxisSize.fraction(0.5) + AxisSize.fixed(40)`,  `AxisSize.fixed(400) * 0.5`, etc."
---

```dart
/// A cross-axis size for a drawer/sheet container, resolved against the
/// available cross-axis extent. Used by [DrawerContainer]/[SheetContainer] to
/// size the sheet so it doesn't stretch edge-to-edge.
///
/// Supports arithmetic: `AxisSize.fraction(0.5) + AxisSize.fixed(40)`,
/// `AxisSize.fixed(400) * 0.5`, etc.
abstract class AxisSize {
  /// Const constructor for subclasses.
  const AxisSize();
  /// A fixed number of logical pixels.
  factory AxisSize.fixed(double size);
  /// A [fraction] (0..1) of the available cross-axis extent.
  factory AxisSize.fraction(double fraction);
  /// Resolves this size against the [available] cross-axis extent.
  double resolve(double available);
  /// Sum of two sizes.
  AxisSize operator +(AxisSize other);
  /// Difference of two sizes.
  AxisSize operator -(AxisSize other);
  /// Scales this size by [factor].
  AxisSize operator *(double factor);
  /// Divides this size by [factor].
  AxisSize operator /(double factor);
}
```
