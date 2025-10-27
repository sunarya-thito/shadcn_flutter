---
title: "Class: HSVColorPickerPainter"
description: "Reference for HSVColorPickerPainter"
---

```dart
class HSVColorPickerPainter extends CustomPainter {
  final HSVColorSliderType sliderType;
  final HSVColor color;
  final bool reverse;
  HSVColorPickerPainter({required this.sliderType, required this.color, this.reverse = false});
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant HSVColorPickerPainter oldDelegate);
}
```
