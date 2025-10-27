---
title: "Example: components/formatted_input/formatted_input_example_4.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class FormattedInputExample4 extends StatefulWidget {
  const FormattedInputExample4({super.key});

  @override
  State<FormattedInputExample4> createState() => _FormattedInputExample4State();
}

class _FormattedInputExample4State extends State<FormattedInputExample4> {
  Duration? _selected;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DurationInput(
          // Built-in formatted control for durations; shows HH:MM and (optionally) SS.
          onChanged: (value) => setState(() => _selected = value),
          showSeconds: true,
        ),
        const Gap(16),
        if (_selected != null) Text('Selected duration: $_selected'),
      ],
    );
  }
}

```
