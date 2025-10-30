---
title: "Class: HSLColorSlider"
description: "Reference for HSLColorSlider"
---

```dart
class HSLColorSlider extends StatefulWidget {
  final HSLColor color;
  final ValueChanged<HSLColor>? onChanging;
  final ValueChanged<HSLColor>? onChanged;
  final HSLColorSliderType sliderType;
  final bool reverse;
  final Radius radius;
  final EdgeInsets padding;
  const HSLColorSlider({super.key, required this.color, this.onChanging, this.onChanged, required this.sliderType, this.reverse = false, this.radius = const Radius.circular(0), this.padding = const EdgeInsets.all(0)});
  State<HSLColorSlider> createState();
}
```
