---
title: "Class: HSLColorSliderPainter"
description: "Reference for HSLColorSliderPainter"
---

```dart
class HSLColorSliderPainter extends CustomPainter {
  final HSLColorSliderType sliderType;
  final HSLColor color;
  final bool reverse;
  HSLColorSliderPainter({required this.sliderType, required this.color, this.reverse = false});
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant HSLColorSliderPainter oldDelegate);
}
```
