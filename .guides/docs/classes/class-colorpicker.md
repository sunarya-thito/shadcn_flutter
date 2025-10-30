---
title: "Class: ColorPicker"
description: "Reference for ColorPicker"
---

```dart
class ColorPicker extends StatefulWidget {
  final ColorDerivative value;
  final ValueChanged<ColorDerivative>? onChanged;
  final ValueChanged<ColorDerivative>? onChanging;
  final bool showAlpha;
  final ColorPickerMode initialMode;
  final ValueChanged<ColorPickerMode>? onModeChanged;
  final VoidCallback? onEyeDropperRequested;
  final bool? enableEyeDropper;
  final Axis? orientation;
  final double? spacing;
  final double? controlSpacing;
  final double? sliderSize;
  const ColorPicker({super.key, required this.value, this.onChanged, this.onChanging, this.showAlpha = false, this.initialMode = ColorPickerMode.rgb, this.onModeChanged, this.enableEyeDropper, this.onEyeDropperRequested, this.orientation, this.spacing, this.controlSpacing, this.sliderSize});
  State<ColorPicker> createState();
}
```
