---
title: "Class: HSVColorPickerArea"
description: "Reference for HSVColorPickerArea"
---

```dart
class HSVColorPickerArea extends StatefulWidget {
  final HSVColor color;
  final ValueChanged<HSVColor>? onColorChanged;
  final ValueChanged<HSVColor>? onColorEnd;
  final HSVColorSliderType sliderType;
  final bool reverse;
  final Radius radius;
  final EdgeInsets padding;
  const HSVColorPickerArea({super.key, required this.color, this.onColorChanged, this.onColorEnd, required this.sliderType, this.reverse = false, this.radius = const Radius.circular(0), this.padding = const EdgeInsets.all(0)});
  State<HSVColorPickerArea> createState();
}
```
