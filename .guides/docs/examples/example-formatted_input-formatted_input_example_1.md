---
title: "Example: components/formatted_input/formatted_input_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class FormattedInputExample1 extends StatelessWidget {
  const FormattedInputExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return FormattedInput(
      // Demonstrates a date-like formatted input built from editable and static parts.
      onChanged: (value) {
        List<String> parts = [];
        for (FormattedValuePart part in value.values) {
          parts.add(part.value ?? '');
        }
        if (kDebugMode) {
          print(parts.join('/'));
        }
      },
      initialValue: FormattedValue([
        const InputPart.editable(length: 2, width: 40, placeholder: Text('MM'))
            .withValue('01'),
        const InputPart.static('/'),
        const InputPart.editable(length: 2, width: 40, placeholder: Text('DD'))
            .withValue('02'),
        const InputPart.static('/'),
        const InputPart.editable(
                length: 4, width: 60, placeholder: Text('YYYY'))
            .withValue('2021'),
      ]),
    );
  }
}

```
