---
title: "Class: TimePickerDialog"
description: "Dialog widget for interactive time selection."
---

```dart
/// Dialog widget for interactive time selection.
///
/// Displays input fields for hours, minutes, and optional seconds
/// with AM/PM toggle for 12-hour format.
class TimePickerDialog extends StatefulWidget {
  /// The initial time value.
  final TimeOfDay? initialValue;
  /// Callback invoked when the time changes.
  final ValueChanged<TimeOfDay?>? onChanged;
  /// Whether to use 24-hour format.
  final bool use24HourFormat;
  /// Whether to show seconds input.
  final bool showSeconds;
  /// Creates a time picker dialog.
  const TimePickerDialog({super.key, this.initialValue, this.onChanged, required this.use24HourFormat, this.showSeconds = false});
  State<TimePickerDialog> createState();
}
```
