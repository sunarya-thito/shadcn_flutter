---
title: "Class: HSLColorPickerPainter"
description: "Reference for HSLColorPickerPainter"
---

```dart
class HSLColorPickerPainter extends CustomPainter {
  final HSLColorSliderType sliderType;
  final HSLColor color;
  final bool reverse;
  HSLColorPickerPainter({required this.sliderType, required this.color, this.reverse = false});
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant HSLColorPickerPainter oldDelegate);
}
```
