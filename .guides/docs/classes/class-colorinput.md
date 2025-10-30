---
title: "Class: ColorInput"
description: "Reference for ColorInput"
---

```dart
class ColorInput extends StatefulWidget {
  final ColorDerivative value;
  final ValueChanged<ColorDerivative>? onChanging;
  final ValueChanged<ColorDerivative>? onChanged;
  final bool? showAlpha;
  final ColorPickerMode? initialMode;
  final bool? enableEyeDropper;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final EdgeInsetsGeometry? popoverPadding;
  final Widget? placeholder;
  final PromptMode? promptMode;
  final Widget? dialogTitle;
  final bool? showLabel;
  final bool? enabled;
  final Axis? orientation;
  const ColorInput({super.key, required this.value, this.onChanging, this.onChanged, this.showAlpha, this.initialMode, this.enableEyeDropper = true, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.placeholder, this.promptMode, this.dialogTitle, this.showLabel, this.orientation, this.enabled});
  State<ColorInput> createState();
}
```
