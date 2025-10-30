---
title: "Class: DateRangePicker"
description: "A widget for selecting a date range."
---

```dart
/// A widget for selecting a date range.
///
/// Provides an interactive date range picker that allows users to select a start
/// and end date. Supports both dialog and popover presentation modes with
/// customizable calendar views and state management.
///
/// Example:
/// ```dart
/// DateRangePicker(
///   value: currentRange,
///   onChanged: (range) => setState(() => currentRange = range),
///   mode: PromptMode.dialog,
/// )
/// ```
class DateRangePicker extends StatelessWidget {
  /// The currently selected date range.
  final DateTimeRange? value;
  /// Callback when the date range changes.
  final ValueChanged<DateTimeRange?>? onChanged;
  /// Placeholder widget shown when no range is selected.
  final Widget? placeholder;
  /// Presentation mode (dialog or popover).
  final PromptMode mode;
  /// Initial calendar view to display.
  final CalendarView? initialView;
  /// Initial view type (date, month, or year).
  final CalendarViewType? initialViewType;
  /// Alignment of popover relative to anchor.
  final AlignmentGeometry? popoverAlignment;
  /// Alignment of anchor for popover positioning.
  final AlignmentGeometry? popoverAnchorAlignment;
  /// Padding inside the popover.
  final EdgeInsetsGeometry? popoverPadding;
  /// Title widget for dialog mode.
  final Widget? dialogTitle;
  /// Callback to determine date state (enabled/disabled).
  final DateStateBuilder? stateBuilder;
  /// Creates a [DateRangePicker].
  ///
  /// Parameters:
  /// - [value] (`DateTimeRange?`, required): Current selected range.
  /// - [onChanged] (`ValueChanged<DateTimeRange?>?`, optional): Called when range changes.
  /// - [placeholder] (`Widget?`, optional): Shown when no range selected.
  /// - [mode] (`PromptMode`, default: `PromptMode.dialog`): Presentation mode.
  /// - [initialView] (`CalendarView?`, optional): Starting calendar view.
  /// - [initialViewType] (`CalendarViewType?`, optional): Starting view type.
  /// - [popoverAlignment] (`AlignmentGeometry?`, optional): Popover alignment.
  /// - [popoverAnchorAlignment] (`AlignmentGeometry?`, optional): Anchor alignment.
  /// - [popoverPadding] (`EdgeInsetsGeometry?`, optional): Popover padding.
  /// - [dialogTitle] (`Widget?`, optional): Dialog title.
  /// - [stateBuilder] (`DateStateBuilder?`, optional): Date state callback.
  const DateRangePicker({super.key, required this.value, this.onChanged, this.placeholder, this.mode = PromptMode.dialog, this.initialView, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.dialogTitle, this.initialViewType, this.stateBuilder});
  Widget build(BuildContext context);
}
```
