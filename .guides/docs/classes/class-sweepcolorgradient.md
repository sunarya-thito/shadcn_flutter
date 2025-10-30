---
title: "Class: SweepColorGradient"
description: "Reference for SweepColorGradient"
---

```dart
class SweepColorGradient extends ColorGradient {
  final List<ColorStop> colors;
  final TileMode tileMode;
  final AlignmentGeometry center;
  final double startAngle;
  final double endAngle;
  const SweepColorGradient({required this.colors, this.tileMode = TileMode.clamp, this.center = Alignment.center, this.startAngle = 0.0, this.endAngle = pi * 2});
  SweepColorGradient copyWith({List<ColorStop>? colors, TileMode? tileMode, AlignmentGeometry? center, double? startAngle, double? endAngle});
  SweepColorGradient changeColorAt(int index, ColorDerivative color);
  SweepColorGradient changePositionAt(int index, double position);
  SweepColorGradient changeColorAndPositionAt(int index, ColorDerivative color, double position);
  ({SweepColorGradient gradient, int index}) insertColorAt(ColorDerivative color, Offset position, Size size, TextDirection textDirection);
  SweepGradient toGradient();
}
```
