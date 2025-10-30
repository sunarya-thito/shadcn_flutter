---
title: "Class: RadialColorGradient"
description: "Reference for RadialColorGradient"
---

```dart
class RadialColorGradient extends ColorGradient {
  final List<ColorStop> colors;
  final TileMode tileMode;
  final AlignmentGeometry center;
  final AlignmentGeometry? focal;
  final double radius;
  final double focalRadius;
  const RadialColorGradient({required this.colors, this.tileMode = TileMode.clamp, this.center = Alignment.center, this.focal, this.radius = 0.5, this.focalRadius = 0.0});
  RadialColorGradient copyWith({List<ColorStop>? colors, TileMode? tileMode, AlignmentGeometry? center, AlignmentGeometry? focal, double? radius, double? focalRadius});
  RadialColorGradient changeColorAt(int index, ColorDerivative color);
  RadialColorGradient changePositionAt(int index, double position);
  RadialColorGradient changeColorAndPositionAt(int index, ColorDerivative color, double position);
  ({RadialColorGradient gradient, int index}) insertColorAt(ColorDerivative color, Offset position, Size size, TextDirection textDirection);
  RadialGradient toGradient();
}
```
