---
title: "Class: TimePickerTheme"
description: "Theme configuration for [TimePicker] widget appearance and behavior."
---

```dart
/// Theme configuration for [TimePicker] widget appearance and behavior.
///
/// Defines default settings for time picker components including display
/// format, popover positioning, and dialog customization.
class TimePickerTheme {
  /// Mode for displaying the time picker (popover or dialog).
  final PromptMode? mode;
  /// Alignment of the popover relative to its anchor.
  final AlignmentGeometry? popoverAlignment;
  /// Alignment point on the anchor widget for popover positioning.
  final AlignmentGeometry? popoverAnchorAlignment;
  /// Padding inside the popover.
  final EdgeInsetsGeometry? popoverPadding;
  /// Whether to use 24-hour time format.
  final bool? use24HourFormat;
  /// Whether to show seconds picker.
  final bool? showSeconds;
  /// Custom title widget for the time picker dialog.
  final Widget? dialogTitle;
  /// Creates a [TimePickerTheme].
  const TimePickerTheme({this.mode, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.use24HourFormat, this.showSeconds, this.dialogTitle});
  /// Creates a copy of this theme with the given fields replaced.
  TimePickerTheme copyWith({ValueGetter<PromptMode?>? mode, ValueGetter<AlignmentGeometry?>? popoverAlignment, ValueGetter<AlignmentGeometry?>? popoverAnchorAlignment, ValueGetter<EdgeInsetsGeometry?>? popoverPadding, ValueGetter<bool?>? use24HourFormat, ValueGetter<bool?>? showSeconds, ValueGetter<Widget?>? dialogTitle});
  bool operator ==(Object other);
  int get hashCode;
}
```
