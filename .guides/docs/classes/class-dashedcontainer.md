---
title: "Class: DashedContainer"
description: "A container with a dashed border outline."
---

```dart
/// A container with a dashed border outline.
///
/// Renders a container with a customizable dashed border that can have rounded
/// corners. Animates border property changes smoothly.
///
/// Example:
/// ```dart
/// DashedContainer(
///   strokeWidth: 10,
///   gap: 5,
///   thickness: 2,
///   borderRadius: BorderRadius.circular(8),
///   child: Padding(
///     padding: EdgeInsets.all(16),
///     child: Text('Dashed border'),
///   ),
/// )
/// ```
class DashedContainer extends StatelessWidget {
  /// Width of each dash segment.
  ///
  /// If `null`, uses scaled default (8).
  final double? strokeWidth;
  /// Gap between consecutive dash segments.
  ///
  /// If `null`, uses scaled default (5).
  final double? gap;
  /// Thickness of the border.
  ///
  /// If `null`, uses scaled default (1).
  final double? thickness;
  /// Color of the dashed border.
  ///
  /// If `null`, uses theme border color.
  final Color? color;
  /// The child widget inside the container.
  final Widget child;
  /// Border radius for rounded corners.
  ///
  /// If `null`, uses theme default border radius.
  final BorderRadiusGeometry? borderRadius;
  /// Creates a [DashedContainer].
  const DashedContainer({super.key, this.strokeWidth, this.gap, this.thickness, this.color, required this.child, this.borderRadius});
  Widget build(BuildContext context);
}
```
