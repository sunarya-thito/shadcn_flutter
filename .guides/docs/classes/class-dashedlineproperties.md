---
title: "Class: DashedLineProperties"
description: "Properties for defining a dashed line appearance."
---

```dart
/// Properties for defining a dashed line appearance.
///
/// Encapsulates the visual properties of a dashed line including dash width,
/// gap between dashes, thickness, and color. Supports interpolation for animations.
class DashedLineProperties {
  /// Width of each dash segment.
  final double width;
  /// Gap between consecutive dash segments.
  final double gap;
  /// Thickness (height) of the line.
  final double thickness;
  /// Color of the dashed line.
  final Color color;
  /// Creates [DashedLineProperties].
  const DashedLineProperties({required this.width, required this.gap, required this.thickness, required this.color});
  /// Linearly interpolates between two [DashedLineProperties].
  static DashedLineProperties lerp(DashedLineProperties a, DashedLineProperties b, double t);
}
```
