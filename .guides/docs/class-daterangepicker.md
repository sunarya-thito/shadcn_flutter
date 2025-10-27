---
title: "Class: DateRangePicker"
description: "Reference for DateRangePicker"
---

```dart
class DateRangePicker extends StatelessWidget {
  final DateTimeRange? value;
  final ValueChanged<DateTimeRange?>? onChanged;
  final Widget? placeholder;
  final PromptMode mode;
  final CalendarView? initialView;
  final CalendarViewType? initialViewType;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final EdgeInsetsGeometry? popoverPadding;
  final Widget? dialogTitle;
  final DateStateBuilder? stateBuilder;
  const DateRangePicker({super.key, required this.value, this.onChanged, this.placeholder, this.mode = PromptMode.dialog, this.initialView, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.dialogTitle, this.initialViewType, this.stateBuilder});
  Widget build(BuildContext context);
}
```
