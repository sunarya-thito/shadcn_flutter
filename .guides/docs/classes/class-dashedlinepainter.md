---
title: "Class: DashedLinePainter"
description: "Reference for DashedLinePainter"
---

```dart
class DashedLinePainter extends CustomPainter {
  final double width;
  final double gap;
  final double thickness;
  final Color color;
  DashedLinePainter({required this.width, required this.gap, required this.thickness, required this.color});
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant DashedLinePainter oldDelegate);
}
```
