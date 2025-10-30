---
title: "Class: LinearColorGradient"
description: "A linear gradient implementation of [ColorGradient]."
---

```dart
/// A linear gradient implementation of [ColorGradient].
///
/// [LinearColorGradient] represents a gradient that transitions linearly between
/// colors along a specified angle. It supports multiple color stops and different
/// tile modes for how the gradient repeats beyond its bounds.
///
/// Example:
/// ```dart
/// final gradient = LinearColorGradient(
///   colors: [
///     ColorStop(color: ColorDerivative.fromColor(Colors.red), position: 0.0),
///     ColorStop(color: ColorDerivative.fromColor(Colors.blue), position: 1.0),
///   ],
///   angle: const GradientAngle(0.0),
/// );
/// ```
class LinearColorGradient extends ColorGradient {
  /// The list of color stops in the gradient.
  final List<ColorStop> colors;
  /// The angle of the gradient.
  final GradientAngleGeometry angle;
  /// How the gradient repeats beyond its bounds.
  final TileMode tileMode;
  /// Creates a [LinearColorGradient] with the specified parameters.
  const LinearColorGradient({required this.colors, this.angle = const DirectionalGradientAngle(0), this.tileMode = TileMode.clamp});
  LinearColorGradient copyWith({List<ColorStop>? colors, GradientAngleGeometry? angle, TileMode? tileMode});
  LinearColorGradient changeColorAt(int index, ColorDerivative color);
  LinearColorGradient changePositionAt(int index, double position);
  LinearColorGradient changeColorAndPositionAt(int index, ColorDerivative color, double position);
  ({LinearColorGradient gradient, int index}) insertColorAt(ColorDerivative color, Offset position, Size size, TextDirection textDirection);
  LinearGradient toGradient();
}
```
