---
title: "Class: DividerPainter"
description: "Reference for DividerPainter"
---

```dart
class DividerPainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double indent;
  final double endIndent;
  DividerPainter({required this.color, required this.thickness, required this.indent, required this.endIndent});
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant DividerPainter oldDelegate);
}
```
