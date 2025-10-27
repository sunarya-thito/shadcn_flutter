---
title: "Example: components/number_input/number_input_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NumberInputExample1 extends StatefulWidget {
  const NumberInputExample1({super.key});

  @override
  State<NumberInputExample1> createState() => _NumberInputExample1State();
}

class _NumberInputExample1State extends State<NumberInputExample1> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 100,
          child: TextField(
            initialValue: value.toString(),
            onChanged: (value) {
              setState(() {
                this.value = double.tryParse(value) ?? 0;
              });
            },
            features: const [
              // Adds stepper/spinner controls to nudge the value up/down.
              InputFeature.spinner(),
            ],
            submitFormatters: [
              // Allow math expressions (e.g., 1+2*3) that resolve on submit.
              TextInputFormatters.mathExpression(),
            ],
          ),
        ),
        gap(8),
        Text('Value: $value'),
      ],
    );
  }
}

```
