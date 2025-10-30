---
title: "Class: DatePicker"
description: "A date picker widget for selecting dates."
---

```dart
/// A date picker widget for selecting dates.
///
/// Provides a date selection interface with calendar view in either
/// popover or dialog mode.
class DatePicker extends StatelessWidget {
  /// The currently selected date value.
  final DateTime? value;
  /// Callback invoked when the selected date changes.
  final ValueChanged<DateTime?>? onChanged;
  /// Placeholder widget shown when no date is selected.
  final Widget? placeholder;
  /// The display mode for the date picker (popover or dialog).
  final PromptMode? mode;
  /// The initial calendar view to display.
  final CalendarView? initialView;
  /// Alignment of the popover relative to the anchor.
  final AlignmentGeometry? popoverAlignment;
  /// Anchor alignment for the popover.
  final AlignmentGeometry? popoverAnchorAlignment;
  /// Padding inside the popover.
  final EdgeInsetsGeometry? popoverPadding;
  /// Title widget for the dialog mode.
  final Widget? dialogTitle;
  /// The initial calendar view type (date, month, or year).
  final CalendarViewType? initialViewType;
  /// Builder function to determine the state of each date.
  final DateStateBuilder? stateBuilder;
  /// Whether the date picker is enabled.
  final bool? enabled;
  /// Creates a date picker.
  const DatePicker({super.key, required this.value, this.onChanged, this.placeholder, this.mode, this.initialView, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.dialogTitle, this.initialViewType, this.stateBuilder, this.enabled});
  Widget build(BuildContext context);
}
```
