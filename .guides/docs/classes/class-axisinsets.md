---
title: "Class: AxisInsets"
description: "Insets along an axis with support for directionality."
---

```dart
/// Insets along an axis with support for directionality.
class AxisInsets extends AxisInsetsGeometry {
  /// The text direction, if any.
  final TextDirection? direction;
  /// The start value.
  final double start;
  /// The end value.
  final double end;
  /// Creates an [AxisInsets].
  ///
  /// Parameters:
  /// - [start] (`double`, required): The start value.
  /// - [end] (`double`, required): The end value.
  const AxisInsets({required this.start, required this.end});
  /// Resolves the start and end values for a specific axis.
  ///
  /// Parameters:
  /// - [axis] (`Axis`, required): The axis to resolve for.
  ///
  /// Returns:
  /// A record containing the start and end values.
  ({double start, double end}) resolveValue(Axis axis);
  AxisInsets resolve(TextDirection textDirection);
}
```
