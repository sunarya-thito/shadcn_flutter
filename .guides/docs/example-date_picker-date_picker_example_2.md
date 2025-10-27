---
title: "Example: components/date_picker/date_picker_example_2.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// DateRangePicker in popover and dialog modes.
///
/// Similar to the single-date picker, but selects a [DateTimeRange].
class DatePickerExample2 extends StatefulWidget {
  const DatePickerExample2({super.key});

  @override
  State<DatePickerExample2> createState() => _DatePickerExample2State();
}

class _DatePickerExample2State extends State<DatePickerExample2> {
  DateTimeRange? _value;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateRangePicker(
          value: _value,
          mode: PromptMode.popover,
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        ),
        const Gap(16),
        DateRangePicker(
          value: _value,
          mode: PromptMode.dialog,
          // Title for the dialog variant.
          dialogTitle: const Text('Select Date Range'),
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        ),
      ],
    );
  }
}

```
