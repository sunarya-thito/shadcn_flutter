---
title: "Class: AxisAlignment"
description: "Alignment along an axis.   Values range from -1.0 (start/left/top) to 1.0 (end/right/bottom)."
---

```dart
/// Alignment along an axis.
///
/// Values range from -1.0 (start/left/top) to 1.0 (end/right/bottom).
class AxisAlignment extends AxisAlignmentGeometry {
  /// Alignment to the left (-1.0).
  static const AxisAlignment left = AxisAlignment(-1.0);
  /// Alignment to the right (1.0).
  static const AxisAlignment right = AxisAlignment(1.0);
  /// Alignment to the center (0.0).
  static const AxisAlignment center = AxisAlignment(0.0);
  /// The text direction, if any.
  final TextDirection? direction;
  /// The alignment value.
  final double value;
  /// Creates an [AxisAlignment].
  ///
  /// Parameters:
  /// - [value] (`double`, required): The alignment value (-1.0 to 1.0).
  const AxisAlignment(this.value);
  /// Resolves the alignment value for a specific axis.
  ///
  /// Parameters:
  /// - [axis] (`Axis`, required): The axis to resolve for.
  ///
  /// Returns:
  /// The resolved alignment value.
  double resolveValue(Axis axis);
  /// Calculates the position along an axis for a given size.
  ///
  /// Parameters:
  /// - [axis] (`Axis`, required): The axis to calculate along.
  /// - [size] (`double`, required): The total size along the axis.
  ///
  /// Returns:
  /// The calculated position.
  double alongValue(Axis axis, double size);
  /// Converts this alignment to a standard [Alignment] with this as the horizontal component.
  ///
  /// Parameters:
  /// - [crossAxisAlignment] (`AxisAlignment`, required): The vertical alignment component.
  ///
  /// Returns:
  /// An [Alignment] combining this horizontal alignment with the given vertical alignment.
  Alignment asHorizontalAlignment(AxisAlignment crossAxisAlignment);
  /// Converts this alignment to a standard [Alignment] with this as the vertical component.
  ///
  /// Parameters:
  /// - [crossAxisAlignment] (`AxisAlignment`, required): The horizontal alignment component.
  ///
  /// Returns:
  /// An [Alignment] combining this vertical alignment with the given horizontal alignment.
  Alignment asVerticalAlignment(AxisAlignment crossAxisAlignment);
  AxisAlignment resolve(TextDirection textDirection);
}
```
