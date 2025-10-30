---
title: "Class: DashedContainerProperties"
description: "Properties for defining a dashed container border appearance."
---

```dart
/// Properties for defining a dashed container border appearance.
///
/// Encapsulates the visual properties of a dashed container border including
/// dash width, gap, thickness, color, and border radius. Supports interpolation.
class DashedContainerProperties {
  /// Width of each dash segment.
  final double width;
  /// Gap between consecutive dash segments.
  final double gap;
  /// Thickness of the border.
  final double thickness;
  /// Color of the dashed border.
  final Color color;
  /// Border radius for rounded corners.
  final BorderRadiusGeometry borderRadius;
  /// Creates [DashedContainerProperties].
  const DashedContainerProperties({required this.width, required this.gap, required this.thickness, required this.color, required this.borderRadius});
  /// Linearly interpolates between two [DashedContainerProperties].
  static DashedContainerProperties lerp(BuildContext context, DashedContainerProperties a, DashedContainerProperties b, double t);
}
```
