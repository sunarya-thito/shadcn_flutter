---
title: "Class: ColorPickerSet"
description: "Reference for ColorPickerSet"
---

```dart
class ColorPickerSet extends StatefulWidget {
  final ColorDerivative color;
  final ValueChanged<ColorDerivative>? onColorChanged;
  final ValueChanged<ColorDerivative>? onColorChangeEnd;
  final bool? showAlpha;
  final VoidCallback? onPickFromScreen;
  final ColorPickerMode mode;
  const ColorPickerSet({super.key, required this.color, this.onColorChanged, this.onColorChangeEnd, this.showAlpha, this.mode = ColorPickerMode.rgb, this.onPickFromScreen});
  State<ColorPickerSet> createState();
}
```
