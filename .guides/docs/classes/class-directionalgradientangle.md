---
title: "Class: DirectionalGradientAngle"
description: "A directional gradient angle that is aware of text direction."
---

```dart
/// A directional gradient angle that is aware of text direction.
///
/// [DirectionalGradientAngle] uses [AlignmentDirectional] for its alignments,
/// making it responsive to the text direction (LTR or RTL). The angle is specified
/// in radians and determines the direction of the gradient.
///
/// Example:
/// ```dart
/// const angle = DirectionalGradientAngle(0.0); // 0 radians (horizontal)
/// final begin = angle.begin; // Start alignment
/// final end = angle.end;     // End alignment
/// ```
class DirectionalGradientAngle extends GradientAngleGeometry {
  /// The angle of the gradient in radians.
  final double angle;
  /// Creates a [DirectionalGradientAngle] with the specified [angle] in radians.
  const DirectionalGradientAngle(this.angle);
  /// The beginning alignment calculated from the angle.
  AlignmentGeometry get begin;
  /// The ending alignment calculated from the angle.
  AlignmentGeometry get end;
}
```
