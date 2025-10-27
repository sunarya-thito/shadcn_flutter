---
title: "Class: ColorInputPopup"
description: "Reference for ColorInputPopup"
---

```dart
class ColorInputPopup extends StatefulWidget {
  final ColorDerivative color;
  final ValueChanged<ColorDerivative>? onChanged;
  final ValueChanged<ColorDerivative>? onColorChangeEnd;
  final bool showAlpha;
  final ColorPickerMode initialMode;
  final VoidCallback? onPickFromScreen;
  final ColorHistoryStorage? storage;
  const ColorInputPopup({super.key, required this.color, this.onChanged, this.onColorChangeEnd, this.showAlpha = true, this.initialMode = ColorPickerMode.rgb, this.onPickFromScreen, this.storage});
  State<ColorInputPopup> createState();
}
```
