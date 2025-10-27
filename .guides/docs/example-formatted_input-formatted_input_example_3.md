---
title: "Example: components/formatted_input/formatted_input_example_3.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class FormattedInputExample3 extends StatefulWidget {
  const FormattedInputExample3({super.key});

  @override
  State<FormattedInputExample3> createState() => _FormattedInputExample3State();
}

class _FormattedInputExample3State extends State<FormattedInputExample3> {
  TimeOfDay? _selected;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TimeInput(
          // Built-in formatted control for time-of-day values.
          onChanged: (value) => setState(() => _selected = value),
        ),
        const Gap(16),
        if (_selected != null) Text('Selected time: $_selected'),
      ],
    );
  }
}

```
