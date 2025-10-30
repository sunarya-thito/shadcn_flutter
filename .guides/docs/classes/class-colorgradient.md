---
title: "Class: ColorGradient"
description: "An abstract base class representing a color gradient with multiple color stops."
---

```dart
/// An abstract base class representing a color gradient with multiple color stops.
///
/// [ColorGradient] provides a common interface for working with gradients that can
/// have colors added, modified, or removed at specific positions. This is useful
/// for creating custom gradient pickers and editors.
///
/// Implementations should handle the gradient type (linear, radial, sweep, etc.)
/// and provide methods to manipulate color stops and their positions.
abstract class ColorGradient {
  /// Creates a const [ColorGradient].
  const ColorGradient();
  /// Creates a copy of this gradient with optional modifications.
  ///
  /// Returns: A new [ColorGradient] instance.
  ColorGradient copyWith();
  /// Changes the color at the specified [index].
  ///
  /// Parameters:
  /// - [index]: The zero-based index of the color stop to modify.
  /// - [color]: The new color for the stop.
  ///
  /// Returns: A new [ColorGradient] with the updated color.
  ColorGradient changeColorAt(int index, ColorDerivative color);
  /// Changes the position of the color stop at the specified [index].
  ///
  /// Parameters:
  /// - [index]: The zero-based index of the color stop to modify.
  /// - [position]: The new position for the stop, typically ranging from 0.0 to 1.0.
  ///
  /// Returns: A new [ColorGradient] with the updated position.
  ColorGradient changePositionAt(int index, double position);
  /// Changes both the color and position at the specified [index].
  ///
  /// Parameters:
  /// - [index]: The zero-based index of the color stop to modify.
  /// - [color]: The new color for the stop.
  /// - [position]: The new position for the stop, typically ranging from 0.0 to 1.0.
  ///
  /// Returns: A new [ColorGradient] with both values updated.
  ColorGradient changeColorAndPositionAt(int index, ColorDerivative color, double position);
  /// Inserts a new color stop at a specific position in the gradient.
  ///
  /// Parameters:
  /// - [color]: The color to insert.
  /// - [position]: The offset position where the color should be inserted.
  /// - [size]: The size of the gradient area.
  /// - [textDirection]: The text direction for resolving directional alignments.
  ///
  /// Returns: A record containing the updated gradient and the index where the color was inserted.
  ({ColorGradient gradient, int index}) insertColorAt(ColorDerivative color, Offset position, Size size, TextDirection textDirection);
  /// Converts this color gradient to a Flutter [Gradient].
  ///
  /// Returns: A [Gradient] object that can be used in Flutter painting operations.
  Gradient toGradient();
}
```
