---
title: "Class: ControlledColorInput"
description: "Reference for ControlledColorInput"
---

```dart
class ControlledColorInput extends StatelessWidget with ControlledComponent<ColorDerivative> {
  final ColorDerivative initialValue;
  final ValueChanged<ColorDerivative>? onChanged;
  final bool enabled;
  final ColorInputController? controller;
  final bool? showAlpha;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final EdgeInsetsGeometry? popoverPadding;
  final Widget? placeholder;
  final PromptMode? promptMode;
  final Widget? dialogTitle;
  final bool? showLabel;
  final Axis? orientation;
  final bool? enableEyeDropper;
  final ColorPickerMode? initialMode;
  final ValueChanged<ColorDerivative>? onChanging;
  const ControlledColorInput({super.key, required this.initialValue, this.onChanged, this.enabled = true, this.controller, this.showAlpha, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.placeholder, this.promptMode, this.dialogTitle, this.showLabel, this.orientation, this.enableEyeDropper, this.initialMode, this.onChanging});
  Widget build(BuildContext context);
}
```
