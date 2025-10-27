---
title: "Class: DurationPicker"
description: "Reference for DurationPicker"
---

```dart
class DurationPicker extends StatelessWidget {
  final Duration? value;
  final ValueChanged<Duration?>? onChanged;
  final PromptMode mode;
  final Widget? placeholder;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final EdgeInsetsGeometry? popoverPadding;
  final Widget? dialogTitle;
  final bool? enabled;
  const DurationPicker({super.key, required this.value, this.onChanged, this.mode = PromptMode.dialog, this.placeholder, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.dialogTitle, this.enabled});
  Widget build(BuildContext context);
}
```
