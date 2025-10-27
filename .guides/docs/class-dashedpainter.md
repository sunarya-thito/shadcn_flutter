---
title: "Class: DashedPainter"
description: "Reference for DashedPainter"
---

```dart
class DashedPainter extends CustomPainter {
  final double width;
  final double gap;
  final double thickness;
  final Color color;
  final BorderRadius? borderRadius;
  DashedPainter({required this.width, required this.gap, required this.thickness, required this.color, this.borderRadius});
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant DashedPainter oldDelegate);
}
```
