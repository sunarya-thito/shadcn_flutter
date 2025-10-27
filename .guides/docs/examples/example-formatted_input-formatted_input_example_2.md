---
title: "Example: components/formatted_input/formatted_input_example_2.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class FormattedInputExample2 extends StatefulWidget {
  const FormattedInputExample2({super.key});

  @override
  State<FormattedInputExample2> createState() => _FormattedInputExample2State();
}

class _FormattedInputExample2State extends State<FormattedInputExample2> {
  DateTime? _selectedDate;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateInput(
          // Built-in formatted control that parses and formats dates.
          onChanged: (value) => setState(() => _selectedDate = value),
        ),
        const Gap(16),
        if (_selectedDate != null) Text('Selected date: $_selectedDate'),
      ],
    );
  }
}

```
