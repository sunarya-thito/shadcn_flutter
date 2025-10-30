---
title: "Class: DashedLine"
description: "A widget that displays a horizontal dashed line."
---

```dart
/// A widget that displays a horizontal dashed line.
///
/// Renders a customizable dashed line with configurable dash width, gap,
/// thickness, and color. Animates changes to properties smoothly.
///
/// Example:
/// ```dart
/// DashedLine(
///   width: 10,
///   gap: 5,
///   thickness: 2,
///   color: Colors.grey,
/// )
/// ```
class DashedLine extends StatelessWidget {
  /// Width of each dash segment.
  ///
  /// If `null`, uses scaled default (8).
  final double? width;
  /// Gap between consecutive dash segments.
  ///
  /// If `null`, uses scaled default (5).
  final double? gap;
  /// Thickness (height) of the line.
  ///
  /// If `null`, uses scaled default (1).
  final double? thickness;
  /// Color of the dashed line.
  ///
  /// If `null`, uses theme border color.
  final Color? color;
  /// Creates a [DashedLine].
  const DashedLine({super.key, this.width, this.gap, this.thickness, this.color});
  Widget build(BuildContext context);
}
```
