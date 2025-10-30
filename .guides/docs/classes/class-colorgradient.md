---
title: "Class: ColorGradient"
description: "Reference for ColorGradient"
---

```dart
abstract class ColorGradient {
  const ColorGradient();
  ColorGradient copyWith();
  ColorGradient changeColorAt(int index, ColorDerivative color);
  ColorGradient changePositionAt(int index, double position);
  ColorGradient changeColorAndPositionAt(int index, ColorDerivative color, double position);
  ({ColorGradient gradient, int index}) insertColorAt(ColorDerivative color, Offset position, Size size, TextDirection textDirection);
  Gradient toGradient();
}
```
