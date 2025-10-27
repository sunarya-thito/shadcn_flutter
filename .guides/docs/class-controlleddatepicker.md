---
title: "Class: ControlledDatePicker"
description: "Reference for ControlledDatePicker"
---

```dart
class ControlledDatePicker extends StatelessWidget with ControlledComponent<DateTime?> {
  final DateTime? initialValue;
  final ValueChanged<DateTime?>? onChanged;
  final bool enabled;
  final DatePickerController? controller;
  final Widget? placeholder;
  final PromptMode? mode;
  final CalendarView? initialView;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final EdgeInsetsGeometry? popoverPadding;
  final Widget? dialogTitle;
  final CalendarViewType? initialViewType;
  final DateStateBuilder? stateBuilder;
  const ControlledDatePicker({super.key, this.controller, this.initialValue, this.onChanged, this.enabled = true, this.placeholder, this.mode, this.initialView, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.dialogTitle, this.initialViewType, this.stateBuilder});
  Widget build(BuildContext context);
}
```
