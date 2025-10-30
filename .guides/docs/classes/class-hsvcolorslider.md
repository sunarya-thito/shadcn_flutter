---
title: "Class: HSVColorSlider"
description: "Reference for HSVColorSlider"
---

```dart
class HSVColorSlider extends StatefulWidget {
  final HSVColor value;
  final ValueChanged<HSVColor>? onChanging;
  final ValueChanged<HSVColor>? onChanged;
  final HSVColorSliderType sliderType;
  final bool reverse;
  final Radius radius;
  final EdgeInsets padding;
  const HSVColorSlider({super.key, required this.value, this.onChanging, this.onChanged, required this.sliderType, this.reverse = false, this.radius = const Radius.circular(0), this.padding = const EdgeInsets.all(0)});
  State<HSVColorSlider> createState();
}
```
