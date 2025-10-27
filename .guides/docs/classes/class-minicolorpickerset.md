---
title: "Class: MiniColorPickerSet"
description: "Reference for MiniColorPickerSet"
---

```dart
class MiniColorPickerSet extends StatefulWidget {
  final ColorDerivative color;
  final ValueChanged<ColorDerivative>? onColorChanged;
  final ValueChanged<ColorDerivative>? onColorChangeEnd;
  final bool? showAlpha;
  final VoidCallback? onPickFromScreen;
  final ColorPickerMode mode;
  const MiniColorPickerSet({super.key, required this.color, this.onColorChanged, this.onColorChangeEnd, this.showAlpha, this.mode = ColorPickerMode.rgb, this.onPickFromScreen});
  State<MiniColorPickerSet> createState();
}
```
