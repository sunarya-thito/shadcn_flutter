---
title: "Class: ColorInput"
description: "Reference for ColorInput"
---

```dart
class ColorInput extends StatelessWidget {
  final ColorDerivative color;
  final ValueChanged<ColorDerivative>? onChanged;
  final bool? showAlpha;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final EdgeInsetsGeometry? popoverPadding;
  final Widget? placeholder;
  final PromptMode? mode;
  final ColorPickerMode? pickerMode;
  final Widget? dialogTitle;
  final bool? allowPickFromScreen;
  final bool? showLabel;
  final ColorHistoryStorage? storage;
  final bool? enabled;
  const ColorInput({super.key, required this.color, this.onChanged, this.showAlpha, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.placeholder, this.mode, this.pickerMode, this.dialogTitle, this.allowPickFromScreen, this.showLabel, this.storage, this.enabled});
  Widget build(BuildContext context);
}
```
