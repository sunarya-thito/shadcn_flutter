---
title: "Class: AxisAlignmentDirectional"
description: "Directional alignment along an axis.   Values range from -1.0 (start) to 1.0 (end)."
---

```dart
/// Directional alignment along an axis.
///
/// Values range from -1.0 (start) to 1.0 (end).
class AxisAlignmentDirectional extends AxisAlignmentGeometry {
  /// Alignment to the start (-1.0).
  static const AxisAlignmentDirectional start = AxisAlignmentDirectional(-1.0);
  /// Alignment to the end (1.0).
  static const AxisAlignmentDirectional end = AxisAlignmentDirectional(1.0);
  /// Alignment to the center (0.0).
  static const AxisAlignmentDirectional center = AxisAlignmentDirectional(0.0);
  /// The alignment value.
  final double value;
  /// Creates an [AxisAlignmentDirectional].
  ///
  /// Parameters:
  /// - [value] (`double`, required): The alignment value (-1.0 to 1.0).
  const AxisAlignmentDirectional(this.value);
  AxisAlignment resolve(TextDirection textDirection);
}
```
