---
title: "Class: VerticalDividerPainter"
description: "Custom painter for drawing vertical divider lines."
---

```dart
/// Custom painter for drawing vertical divider lines.
///
/// Renders a vertical line with specified color, thickness, and indents.
class VerticalDividerPainter extends CustomPainter {
  /// The color of the divider line.
  final Color color;
  /// The thickness of the divider line.
  final double thickness;
  /// The indent from the top edge.
  final double indent;
  /// The indent from the bottom edge.
  final double endIndent;
  /// Creates a vertical divider painter with the specified properties.
  const VerticalDividerPainter({required this.color, required this.thickness, required this.indent, required this.endIndent});
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant VerticalDividerPainter oldDelegate);
}
```
