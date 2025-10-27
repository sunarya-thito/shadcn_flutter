---
title: "Class: TimePicker"
description: "Reference for TimePicker"
---

```dart
class TimePicker extends StatelessWidget {
  final TimeOfDay? value;
  final ValueChanged<TimeOfDay?>? onChanged;
  final PromptMode mode;
  final Widget? placeholder;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final EdgeInsetsGeometry? popoverPadding;
  final bool? use24HourFormat;
  final bool showSeconds;
  final Widget? dialogTitle;
  final bool? enabled;
  const TimePicker({super.key, required this.value, this.onChanged, this.mode = PromptMode.dialog, this.placeholder, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.use24HourFormat, this.showSeconds = false, this.dialogTitle, this.enabled});
  Widget build(BuildContext context);
}
```
