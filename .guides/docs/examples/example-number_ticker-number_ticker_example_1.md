---
title: "Example: components/number_ticker/number_ticker_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:intl/intl.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates NumberTicker animating from its previous value to a new value.
// The TextField lets you enter a target integer; committing the edit triggers
// the ticker to animate the change. A formatter compact-prints large numbers.

class NumberTickerExample1 extends StatefulWidget {
  const NumberTickerExample1({super.key});

  @override
  State<NumberTickerExample1> createState() => _NumberTickerExample1State();
}

class _NumberTickerExample1State extends State<NumberTickerExample1> {
  // Current target number. Changing this causes NumberTicker to animate
  // from the old value to the new value.
  int _number = 0;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberTicker(
          // Starting point for the first animation frame.
          initialNumber: 0,
          // The live value to animate toward. When this changes, the ticker
          // interpolates between the previous and the new value.
          number: _number,
          style: const TextStyle(fontSize: 32),
          formatter: (number) {
            // Optional display formatter: 1200 -> 1.2K, etc.
            return NumberFormat.compact().format(number);
          },
        ),
        const Gap(24),
        TextField(
          // Show the current number as the initial text.
          initialValue: _number.toString(),
          controller: _controller,
          onEditingComplete: () {
            // Commit input on edit complete and update the ticker target.
            int? number = int.tryParse(_controller.text);
            if (number != null) {
              setState(() {
                _number = number;
              });
            }
          },
        )
      ],
    );
  }
}

```
