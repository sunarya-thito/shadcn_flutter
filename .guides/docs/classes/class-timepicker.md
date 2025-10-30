---
title: "Class: TimePicker"
description: "A time picker widget for selecting time values."
---

```dart
/// A time picker widget for selecting time values.
///
/// Provides time selection interface with hours, minutes, and optional
/// seconds in either popover or dialog mode.
class TimePicker extends StatelessWidget {
  /// The currently selected time value.
  final TimeOfDay? value;
  /// Callback invoked when the selected time changes.
  final ValueChanged<TimeOfDay?>? onChanged;
  /// The display mode for the time picker (popover or dialog).
  final PromptMode mode;
  /// Placeholder widget shown when no time is selected.
  final Widget? placeholder;
  /// Alignment of the popover relative to the anchor.
  final AlignmentGeometry? popoverAlignment;
  /// Anchor alignment for the popover.
  final AlignmentGeometry? popoverAnchorAlignment;
  /// Padding inside the popover.
  final EdgeInsetsGeometry? popoverPadding;
  /// Whether to use 24-hour format.
  final bool? use24HourFormat;
  /// Whether to show seconds selection.
  final bool showSeconds;
  /// Title widget for the dialog mode.
  final Widget? dialogTitle;
  /// Whether the time picker is enabled.
  final bool? enabled;
  /// Creates a time picker.
  const TimePicker({super.key, required this.value, this.onChanged, this.mode = PromptMode.dialog, this.placeholder, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.use24HourFormat, this.showSeconds = false, this.dialogTitle, this.enabled});
  Widget build(BuildContext context);
}
```
