---
title: "Class: VerticalDividerPainter"
description: "Reference for VerticalDividerPainter"
---

```dart
class VerticalDividerPainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double indent;
  final double endIndent;
  const VerticalDividerPainter({required this.color, required this.thickness, required this.indent, required this.endIndent});
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant VerticalDividerPainter oldDelegate);
}
```
