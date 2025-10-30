---
title: "Class: EyeDropperResult"
description: "Represents the result of an eye dropper color picking operation."
---

```dart
/// Represents the result of an eye dropper color picking operation.
///
/// [EyeDropperResult] contains the picked color along with all colors
/// captured in the sampling area. This allows for accessing individual
/// pixels from the captured region.
class EyeDropperResult {
  /// The size of the captured area.
  final Size size;
  /// All colors in the captured area, stored row by row.
  final List<Color> colors;
  /// The specific color that was picked by the user.
  final Color pickedColor;
  /// Creates an [EyeDropperResult].
  const EyeDropperResult(this.colors, this.size, this.pickedColor);
  /// Gets the color at the specified position in the captured area.
  ///
  /// Parameters:
  /// - [position]: The offset position within the captured area.
  ///
  /// Returns: The color at that position.
  Color operator [](Offset position);
}
```
