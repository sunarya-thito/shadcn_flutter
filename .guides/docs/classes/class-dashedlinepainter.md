---
title: "Class: DashedLinePainter"
description: "A custom painter that draws a dashed horizontal line."
---

```dart
/// A custom painter that draws a dashed horizontal line.
///
/// Paints a line with alternating dashes and gaps.
class DashedLinePainter extends CustomPainter {
  /// Width of each dash segment.
  final double width;
  /// Gap between dash segments.
  final double gap;
  /// Thickness of the line.
  final double thickness;
  /// Color of the dashed line.
  final Color color;
  /// Creates a [DashedLinePainter].
  ///
  /// Parameters:
  /// - [width] (`double`, required): Dash segment width.
  /// - [gap] (`double`, required): Gap between dashes.
  /// - [thickness] (`double`, required): Line thickness.
  /// - [color] (`Color`, required): Line color.
  DashedLinePainter({required this.width, required this.gap, required this.thickness, required this.color});
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant DashedLinePainter oldDelegate);
}
```
