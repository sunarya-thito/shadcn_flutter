---
title: "Class: DurationPicker"
description: "Widget for picking duration values with day, hour, minute, and second components."
---

```dart
/// Widget for picking duration values with day, hour, minute, and second components.
///
/// Provides an input interface for selecting time durations. Can be controlled
/// externally via [DurationPickerController] or used with callbacks.
///
/// Example:
/// ```dart
/// DurationPicker(
///   value: Duration(hours: 1, minutes: 30),
///   onChanged: (duration) {
///     print('Selected: $duration');
///   },
/// )
/// ```
class DurationPicker extends StatelessWidget {
  /// The currently selected duration value.
  final Duration? value;
  /// Callback invoked when the selected duration changes.
  final ValueChanged<Duration?>? onChanged;
  /// The display mode for the duration picker (popover or dialog).
  final PromptMode mode;
  /// Placeholder widget shown when no duration is selected.
  final Widget? placeholder;
  /// Alignment of the popover relative to the anchor.
  final AlignmentGeometry? popoverAlignment;
  /// Anchor alignment for the popover.
  final AlignmentGeometry? popoverAnchorAlignment;
  /// Padding inside the popover.
  final EdgeInsetsGeometry? popoverPadding;
  /// Title widget for the dialog mode.
  final Widget? dialogTitle;
  /// Whether the duration picker is enabled.
  final bool? enabled;
  /// Creates a duration picker.
  const DurationPicker({super.key, required this.value, this.onChanged, this.mode = PromptMode.dialog, this.placeholder, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.dialogTitle, this.enabled});
  Widget build(BuildContext context);
}
```
