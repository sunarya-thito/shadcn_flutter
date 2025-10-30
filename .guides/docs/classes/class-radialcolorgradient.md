---
title: "Class: RadialColorGradient"
description: "A radial gradient for color values."
---

```dart
/// A radial gradient for color values.
///
/// Creates a circular gradient radiating from a center point.
class RadialColorGradient extends ColorGradient {
  /// The color stops defining the gradient.
  final List<ColorStop> colors;
  /// How the gradient tiles beyond its bounds.
  final TileMode tileMode;
  /// The center point of the gradient.
  final AlignmentGeometry center;
  /// The focal point of the gradient (for elliptical gradients).
  final AlignmentGeometry? focal;
  /// The radius of the gradient (0.0 to 1.0).
  final double radius;
  /// The focal radius for elliptical gradients.
  final double focalRadius;
  /// Creates a radial color gradient.
  const RadialColorGradient({required this.colors, this.tileMode = TileMode.clamp, this.center = Alignment.center, this.focal, this.radius = 0.5, this.focalRadius = 0.0});
  RadialColorGradient copyWith({List<ColorStop>? colors, TileMode? tileMode, AlignmentGeometry? center, AlignmentGeometry? focal, double? radius, double? focalRadius});
  RadialColorGradient changeColorAt(int index, ColorDerivative color);
  RadialColorGradient changePositionAt(int index, double position);
  RadialColorGradient changeColorAndPositionAt(int index, ColorDerivative color, double position);
  ({RadialColorGradient gradient, int index}) insertColorAt(ColorDerivative color, Offset position, Size size, TextDirection textDirection);
  RadialGradient toGradient();
}
```
