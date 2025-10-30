---
title: "Class: DividerProperties"
description: "Immutable properties for divider appearance."
---

```dart
/// Immutable properties for divider appearance.
///
/// [DividerProperties] stores the visual characteristics of a divider,
/// including color, thickness, and indentation. This class is used for
/// theme interpolation and default value management.
///
/// All properties are required and non-nullable.
class DividerProperties {
  /// The color of the divider line.
  final Color color;
  /// The thickness of the divider line in logical pixels.
  final double thickness;
  /// The amount of empty space to the leading edge of the divider.
  final double indent;
  /// The amount of empty space to the trailing edge of the divider.
  final double endIndent;
  /// Creates divider properties with the specified values.
  const DividerProperties({required this.color, required this.thickness, required this.indent, required this.endIndent});
  /// Linearly interpolates between two [DividerProperties] objects.
  ///
  /// Used for smooth theme transitions. Parameter [t] should be between 0.0 and 1.0,
  /// where 0.0 returns [a] and 1.0 returns [b].
  static DividerProperties lerp(DividerProperties a, DividerProperties b, double t);
}
```
