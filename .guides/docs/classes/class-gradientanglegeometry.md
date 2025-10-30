---
title: "Class: GradientAngleGeometry"
description: "An abstract base class for representing gradient angles with alignment geometry."
---

```dart
/// An abstract base class for representing gradient angles with alignment geometry.
///
/// [GradientAngleGeometry] provides an interface for converting between angular
/// representation and alignment-based gradients. It supports both directional
/// (text-direction-aware) and non-directional gradient angles.
///
/// Subclasses should implement how to calculate begin and end alignments based
/// on the angle value.
abstract class GradientAngleGeometry {
  /// Creates a const [GradientAngleGeometry].
  const GradientAngleGeometry();
  /// The angle of the gradient in radians.
  double get angle;
  /// The beginning alignment of the gradient.
  AlignmentGeometry get begin;
  /// The ending alignment of the gradient.
  AlignmentGeometry get end;
  /// Converts this to a directional gradient angle.
  ///
  /// Returns: A [DirectionalGradientAngle] based on this angle.
  DirectionalGradientAngle toDirectional();
  /// Converts this to a non-directional gradient angle.
  ///
  /// Returns: A [GradientAngle] based on this angle.
  GradientAngle toNonDirectional();
}
```
