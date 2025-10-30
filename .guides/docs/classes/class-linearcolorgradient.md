---
title: "Class: LinearColorGradient"
description: "Reference for LinearColorGradient"
---

```dart
class LinearColorGradient extends ColorGradient {
  final List<ColorStop> colors;
  final GradientAngleGeometry angle;
  final TileMode tileMode;
  const LinearColorGradient({required this.colors, this.angle = const DirectionalGradientAngle(0), this.tileMode = TileMode.clamp});
  LinearColorGradient copyWith({List<ColorStop>? colors, GradientAngleGeometry? angle, TileMode? tileMode});
  LinearColorGradient changeColorAt(int index, ColorDerivative color);
  LinearColorGradient changePositionAt(int index, double position);
  LinearColorGradient changeColorAndPositionAt(int index, ColorDerivative color, double position);
  ({LinearColorGradient gradient, int index}) insertColorAt(ColorDerivative color, Offset position, Size size, TextDirection textDirection);
  LinearGradient toGradient();
}
```
