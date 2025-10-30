---
title: "Class: HSVColorSliderPainter"
description: "Reference for HSVColorSliderPainter"
---

```dart
class HSVColorSliderPainter extends CustomPainter {
  final HSVColorSliderType sliderType;
  final HSVColor color;
  final bool reverse;
  HSVColorSliderPainter({required this.sliderType, required this.color, this.reverse = false});
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant HSVColorSliderPainter oldDelegate);
}
```
