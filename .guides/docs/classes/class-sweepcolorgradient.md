---
title: "Class: SweepColorGradient"
description: "A sweep (angular/conical) gradient for color values."
---

```dart
/// A sweep (angular/conical) gradient for color values.
///
/// Creates a gradient that sweeps around a center point.
class SweepColorGradient extends ColorGradient {
  /// The color stops defining the gradient.
  final List<ColorStop> colors;
  /// How the gradient tiles beyond its bounds.
  final TileMode tileMode;
  /// The center point of the gradient.
  final AlignmentGeometry center;
  /// The starting angle in radians.
  final double startAngle;
  /// The ending angle in radians.
  final double endAngle;
  /// Creates a sweep color gradient.
  const SweepColorGradient({required this.colors, this.tileMode = TileMode.clamp, this.center = Alignment.center, this.startAngle = 0.0, this.endAngle = pi * 2});
  SweepColorGradient copyWith({List<ColorStop>? colors, TileMode? tileMode, AlignmentGeometry? center, double? startAngle, double? endAngle});
  SweepColorGradient changeColorAt(int index, ColorDerivative color);
  SweepColorGradient changePositionAt(int index, double position);
  SweepColorGradient changeColorAndPositionAt(int index, ColorDerivative color, double position);
  ({SweepColorGradient gradient, int index}) insertColorAt(ColorDerivative color, Offset position, Size size, TextDirection textDirection);
  SweepGradient toGradient();
}
```
