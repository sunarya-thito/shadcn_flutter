---
title: "Class: GradientAngle"
description: "A non-directional gradient angle that uses standard [Alignment]."
---

```dart
/// A non-directional gradient angle that uses standard [Alignment].
///
/// Unlike [DirectionalGradientAngle], this class uses non-directional [Alignment]
/// and is not affected by text direction. The angle is specified in radians.
///
/// Example:
/// ```dart
/// const angle = GradientAngle(pi / 4); // 45 degrees
/// final begin = angle.begin;
/// final end = angle.end;
/// ```
class GradientAngle extends GradientAngleGeometry {
  /// The angle of the gradient in radians.
  final double angle;
  /// Creates a [GradientAngle] with the specified [angle] in radians.
  const GradientAngle(this.angle);
  /// The beginning alignment calculated from the angle.
  AlignmentGeometry get begin;
  /// The ending alignment calculated from the angle.
  AlignmentGeometry get end;
}
```
