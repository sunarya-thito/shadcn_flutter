---
title: "Class: DatePicker"
description: "Reference for DatePicker"
---

```dart
class DatePicker extends StatelessWidget {
  final DateTime? value;
  final ValueChanged<DateTime?>? onChanged;
  final Widget? placeholder;
  final PromptMode? mode;
  final CalendarView? initialView;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final EdgeInsetsGeometry? popoverPadding;
  final Widget? dialogTitle;
  final CalendarViewType? initialViewType;
  final DateStateBuilder? stateBuilder;
  final bool? enabled;
  const DatePicker({super.key, required this.value, this.onChanged, this.placeholder, this.mode, this.initialView, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.dialogTitle, this.initialViewType, this.stateBuilder, this.enabled});
  Widget build(BuildContext context);
}
```
