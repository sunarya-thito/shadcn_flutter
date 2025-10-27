---
title: "Class: HSLColorPickerArea"
description: "Reference for HSLColorPickerArea"
---

```dart
class HSLColorPickerArea extends StatefulWidget {
  final HSLColor color;
  final ValueChanged<HSLColor>? onColorChanged;
  final ValueChanged<HSLColor>? onColorEnd;
  final HSLColorSliderType sliderType;
  final bool reverse;
  final Radius radius;
  final EdgeInsets padding;
  const HSLColorPickerArea({super.key, required this.color, this.onColorChanged, this.onColorEnd, required this.sliderType, this.reverse = false, this.radius = const Radius.circular(0), this.padding = const EdgeInsets.all(0)});
  State<HSLColorPickerArea> createState();
}
```
