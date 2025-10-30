---
title: "Class: ControlledTimePicker"
description: "A controlled time picker widget for selecting time values with external state management."
---

```dart
/// A controlled time picker widget for selecting time values with external state management.
///
/// This widget provides a time selection interface that can be controlled either through
/// a [TimePickerController] or through direct property values. It supports multiple
/// presentation modes (dialog or popover), customizable time formats (12-hour/24-hour),
/// and optional seconds display.
///
/// The time picker integrates with the controlled component system, making it suitable
/// for form integration, validation, and programmatic control. It presents the selected
/// time in a readable format and opens an interactive time selection interface when activated.
///
/// Example:
/// ```dart
/// ControlledTimePicker(
///   initialValue: TimeOfDay(hour: 9, minute: 30),
///   use24HourFormat: true,
///   showSeconds: false,
///   placeholder: Text('Select meeting time'),
///   onChanged: (time) {
///     print('Selected time: ${time?.format(context)}');
///   },
/// );
/// ```
class ControlledTimePicker extends StatelessWidget with ControlledComponent<TimeOfDay?> {
  final TimeOfDay? initialValue;
  final ValueChanged<TimeOfDay?>? onChanged;
  final bool enabled;
  final TimePickerController? controller;
  /// The presentation mode for the time picker interface.
  ///
  /// Determines how the time selection interface is displayed to the user.
  /// Can be either dialog mode (modal popup) or popover mode (dropdown).
  final PromptMode mode;
  /// Widget displayed when no time is selected.
  ///
  /// This placeholder appears in the picker button when [initialValue] is null
  /// and no time has been selected yet. If null, a default placeholder is used.
  final Widget? placeholder;
  /// Alignment for the popover relative to its anchor widget.
  ///
  /// Used only when [mode] is [PromptMode.popover]. Controls where the popover
  /// appears relative to the picker button.
  final AlignmentGeometry? popoverAlignment;
  /// Alignment of the anchor point on the picker button.
  ///
  /// Used only when [mode] is [PromptMode.popover]. Determines which point
  /// on the picker button the popover aligns to.
  final AlignmentGeometry? popoverAnchorAlignment;
  /// Internal padding for the popover content.
  ///
  /// Used only when [mode] is [PromptMode.popover]. Controls spacing inside
  /// the popover container around the time picker interface.
  final EdgeInsetsGeometry? popoverPadding;
  /// Whether to use 24-hour format for time display and input.
  ///
  /// When true, times are displayed in 24-hour format (00:00-23:59).
  /// When false or null, uses the system default format preference.
  final bool? use24HourFormat;
  /// Whether to include seconds in the time selection.
  ///
  /// When true, the time picker allows selection of seconds in addition
  /// to hours and minutes. When false, only hours and minutes are selectable.
  final bool showSeconds;
  /// Optional title widget for the dialog mode.
  ///
  /// Used only when [mode] is [PromptMode.dialog]. Displayed at the top
  /// of the modal time picker dialog.
  final Widget? dialogTitle;
  /// Creates a [ControlledTimePicker].
  ///
  /// Either [controller] or [initialValue] should be provided to establish
  /// the initial time state. The picker can be customized with various
  /// presentation options and time format preferences.
  ///
  /// Parameters:
  /// - [controller] (TimePickerController?, optional): External controller for programmatic control
  /// - [initialValue] (TimeOfDay?, optional): Initial time when no controller is provided
  /// - [onChanged] (`ValueChanged<TimeOfDay?>?`, optional): Callback for time selection changes
  /// - [enabled] (bool, default: true): Whether the picker accepts user interaction
  /// - [mode] (PromptMode, default: PromptMode.dialog): Presentation style (dialog or popover)
  /// - [placeholder] (Widget?, optional): Content displayed when no time is selected
  /// - [popoverAlignment] (AlignmentGeometry?, optional): Popover positioning relative to anchor
  /// - [popoverAnchorAlignment] (AlignmentGeometry?, optional): Anchor point on picker button
  /// - [popoverPadding] (EdgeInsetsGeometry?, optional): Internal popover content padding
  /// - [use24HourFormat] (bool?, optional): Whether to use 24-hour time format
  /// - [showSeconds] (bool, default: false): Whether to include seconds selection
  /// - [dialogTitle] (Widget?, optional): Title for dialog mode display
  ///
  /// Example:
  /// ```dart
  /// ControlledTimePicker(
  ///   initialValue: TimeOfDay(hour: 14, minute: 30),
  ///   mode: PromptMode.popover,
  ///   use24HourFormat: true,
  ///   onChanged: (time) => print('Selected: $time'),
  /// );
  /// ```
  const ControlledTimePicker({super.key, this.controller, this.initialValue, this.onChanged, this.enabled = true, this.mode = PromptMode.dialog, this.placeholder, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.use24HourFormat, this.showSeconds = false, this.dialogTitle});
  Widget build(BuildContext context);
}
```
