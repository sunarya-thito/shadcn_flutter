---
title: "Class: DividerPainter"
description: "Custom painter for drawing horizontal divider lines."
---

```dart
/// Custom painter for drawing horizontal divider lines.
///
/// Renders a horizontal line with specified color, thickness, and indents.
class DividerPainter extends CustomPainter {
  /// The color of the divider line.
  final Color color;
  /// The thickness of the divider line.
  final double thickness;
  /// The indent from the start edge.
  final double indent;
  /// The indent from the end edge.
  final double endIndent;
  /// Creates a divider painter with the specified properties.
  DividerPainter({required this.color, required this.thickness, required this.indent, required this.endIndent});
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant DividerPainter oldDelegate);
}
```
