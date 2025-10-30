---
title: "Class: DashedPainter"
description: "A custom painter that draws a dashed border around a rectangle."
---

```dart
/// A custom painter that draws a dashed border around a rectangle.
///
/// Paints a dashed border with optional rounded corners.
class DashedPainter extends CustomPainter {
  /// Width of each dash segment.
  final double width;
  /// Gap between dash segments.
  final double gap;
  /// Thickness of the border.
  final double thickness;
  /// Color of the dashed border.
  final Color color;
  /// Border radius for rounded corners.
  final BorderRadius? borderRadius;
  /// Creates a [DashedPainter].
  ///
  /// Parameters:
  /// - [width] (`double`, required): Dash segment width.
  /// - [gap] (`double`, required): Gap between dashes.
  /// - [thickness] (`double`, required): Border thickness.
  /// - [color] (`Color`, required): Border color.
  /// - [borderRadius] (`BorderRadius?`, optional): Corner radius.
  DashedPainter({required this.width, required this.gap, required this.thickness, required this.color, this.borderRadius});
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant DashedPainter oldDelegate);
}
```
