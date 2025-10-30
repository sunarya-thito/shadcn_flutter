---
title: "Class: ColorStop"
description: "Represents a color stop in a gradient with a specific color and position."
---

```dart
/// Represents a color stop in a gradient with a specific color and position.
///
/// A color stop defines where a particular color appears along a gradient.
/// The position is typically a value between 0.0 (start) and 1.0 (end).
///
/// Example:
/// ```dart
/// const stop = ColorStop(
///   color: ColorDerivative.fromColor(Colors.blue),
///   position: 0.5, // Middle of the gradient
/// );
/// ```
class ColorStop {
  /// The color at this stop.
  final ColorDerivative color;
  /// The position of this stop along the gradient, typically from 0.0 to 1.0.
  final double position;
  /// Creates a [ColorStop] with the specified [color] and [position].
  const ColorStop({required this.color, required this.position});
}
```
