---
title: "Class: ColorInputSet"
description: "Reference for ColorInputSet"
---

```dart
class ColorInputSet extends StatefulWidget {
  final ColorDerivative color;
  final ValueChanged<ColorDerivative>? onChanged;
  final ValueChanged<ColorDerivative>? onColorChangeEnd;
  final bool? showAlpha;
  final ColorPickerMode mode;
  final ValueChanged<ColorPickerMode>? onModeChanged;
  final VoidCallback? onPickFromScreen;
  final ColorHistoryStorage? storage;
  const ColorInputSet({super.key, required this.color, this.onChanged, this.onColorChangeEnd, this.showAlpha = true, this.mode = ColorPickerMode.rgb, this.onModeChanged, this.onPickFromScreen, this.storage});
  State<ColorInputSet> createState();
}
```
