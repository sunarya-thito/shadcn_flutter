---
title: "Example: components/slider/slider_example_3.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SliderExample3 extends StatefulWidget {
  const SliderExample3({super.key});

  @override
  State<SliderExample3> createState() => _SliderExample3State();
}

class _SliderExample3State extends State<SliderExample3> {
  // Single-value slider with a custom range and discrete divisions.
  SliderValue value = const SliderValue.single(0.5);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Slider(
          // Allow values from 0 to 2 with 10 discrete steps.
          max: 2,
          divisions: 10,
          value: value,
          onChanged: (value) {
            setState(() {
              this.value = value;
            });
          },
        ),
        const Gap(16),
        // Show the current numeric value.
        Text('Value: ${value.value}'),
      ],
    );
  }
}

```
