---
title: "Example: components/color_picker/color_picker_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ColorPickerExample1 extends StatefulWidget {
  const ColorPickerExample1({super.key});

  @override
  State<ColorPickerExample1> createState() => _ColorPickerExample1State();
}

class _ColorPickerExample1State extends State<ColorPickerExample1> {
  ColorDerivative color = ColorDerivative.fromColor(Colors.blue);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: ColorInput(
              // A compact square color input that opens a popover prompt.
              value: color,
              orientation: Axis.horizontal,
              promptMode: PromptMode.popover,
              onChanged: (value) {
                setState(() {
                  color = value;
                });
              },
            ),
          ),
          const Gap(16),
          ColorInput(
            value: color,
            // Full dialog mode with a title.
            promptMode: PromptMode.dialog,
            dialogTitle: const Text('Select Color'),
            onChanged: (value) {
              setState(() {
                color = value;
              });
            },
            // Show the textual label/hex alongside the swatch.
            showLabel: true,
          ),
        ],
      ),
    );
  }
}

```
