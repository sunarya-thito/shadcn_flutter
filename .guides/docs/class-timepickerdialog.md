---
title: "Class: TimePickerDialog"
description: "Reference for TimePickerDialog"
---

```dart
class TimePickerDialog extends StatefulWidget {
  final TimeOfDay? initialValue;
  final ValueChanged<TimeOfDay?>? onChanged;
  final bool use24HourFormat;
  final bool showSeconds;
  const TimePickerDialog({super.key, this.initialValue, this.onChanged, required this.use24HourFormat, this.showSeconds = false});
  State<TimePickerDialog> createState();
}
```
