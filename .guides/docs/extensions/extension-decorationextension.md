---
title: "Extension: DecorationExtension"
description: "Extension methods for [Decoration] providing type-safe copyWith operations."
---

```dart
/// Extension methods for [Decoration] providing type-safe copyWith operations.
///
/// Adds convenience methods to [Decoration] for creating modified copies when
/// the decoration is either a [BoxDecoration] or [ShapeDecoration]. These methods
/// handle type checking and provide appropriate defaults when the decoration
/// doesn't match the expected type.
extension DecorationExtension on Decoration {
  /// Creates a [BoxDecoration] copy with specified properties replaced.
  ///
  /// If this decoration is a [BoxDecoration], creates a modified copy.
  /// Otherwise, creates a new [BoxDecoration] with the provided properties.
  ///
  /// Parameters:
  /// - [color]: Replacement or new background color
  /// - [image]: Replacement or new decoration image
  /// - [border]: Replacement or new border
  /// - [borderRadius]: Replacement or new border radius
  /// - [boxShadow]: Replacement or new shadow list
  /// - [gradient]: Replacement or new gradient
  /// - [shape]: Replacement or new box shape
  /// - [backgroundBlendMode]: Replacement or new blend mode
  ///
  /// Returns a [BoxDecoration] with the specified properties.
  BoxDecoration copyWithIfBoxDecoration({Color? color, DecorationImage? image, BoxBorder? border, BorderRadiusGeometry? borderRadius, List<BoxShadow>? boxShadow, Gradient? gradient, BoxShape? shape, BlendMode? backgroundBlendMode});
  /// Creates a [ShapeDecoration] copy with specified properties replaced.
  ///
  /// If this decoration is a [ShapeDecoration], creates a modified copy.
  /// Otherwise, creates a new [ShapeDecoration] with the provided properties.
  ///
  /// Parameters:
  /// - [shape]: Replacement or new shape border
  /// - [color]: Replacement or new fill color
  /// - [gradient]: Replacement or new gradient
  /// - [shadows]: Replacement or new shadow list
  /// - [image]: Replacement or new decoration image
  ///
  /// Returns a [ShapeDecoration] with the specified properties.
  ShapeDecoration copyWithIfShapeDecoration({ShapeBorder? shape, Color? color, Gradient? gradient, List<BoxShadow>? shadows, DecorationImage? image});
}
```
