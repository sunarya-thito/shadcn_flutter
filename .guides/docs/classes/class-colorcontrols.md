---
title: "Class: ColorControls"
description: "Reference for ColorControls"
---

```dart
class ColorControls extends StatelessWidget {
  final ColorDerivative value;
  final ValueChanged<ColorDerivative>? onChanged;
  final ValueChanged<ColorDerivative>? onChanging;
  final ValueChanged<ColorPickerMode>? onModeChanged;
  final bool showAlpha;
  final ColorPickerMode mode;
  final double? controlSpacing;
  final bool? enableEyeDropper;
  final VoidCallback? onEyeDropperRequested;
  const ColorControls({super.key, required this.value, this.onChanged, this.onChanging, this.onModeChanged, this.showAlpha = false, this.mode = ColorPickerMode.rgb, this.enableEyeDropper, this.onEyeDropperRequested, this.controlSpacing});
  Widget build(BuildContext context);
  List<Widget> buildInputs(BuildContext context);
  List<Widget> buildRGBInputs(BuildContext context);
  List<Widget> buildHSLInputs(BuildContext context);
  List<Widget> buildHSVInputs(BuildContext context);
  List<Widget> buildHEXInputs(BuildContext context);
}
```
