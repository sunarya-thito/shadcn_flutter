---
title: "Extension: ShapeDecorationExtension"
description: "Extension methods for [ShapeDecoration] providing copyWith functionality."
---

```dart
/// Extension methods for [ShapeDecoration] providing copyWith functionality.
///
/// Adds a `copyWith` method to [ShapeDecoration] for creating modified copies
/// with selectively updated properties, similar to the pattern used in Flutter
/// for other decoration types.
extension ShapeDecorationExtension on ShapeDecoration {
  /// Creates a copy of this [ShapeDecoration] with specified properties replaced.
  ///
  /// Parameters:
  /// - [shape]: Replacement shape border
  /// - [color]: Replacement fill color
  /// - [gradient]: Replacement gradient
  /// - [shadows]: Replacement shadow list
  /// - [image]: Replacement decoration image
  ///
  /// Returns a new [ShapeDecoration] with the specified properties updated
  /// and all other properties copied from the original.
  ShapeDecoration copyWith({ShapeBorder? shape, Color? color, Gradient? gradient, List<BoxShadow>? shadows, DecorationImage? image});
}
```
