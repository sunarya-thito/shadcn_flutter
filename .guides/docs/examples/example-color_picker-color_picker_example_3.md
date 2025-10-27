---
title: "Example: components/color_picker/color_picker_example_3.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ColorPickerExample3 extends StatelessWidget {
  const ColorPickerExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PrimaryButton(
          onPressed: () {
            // Show the color picker as a popover anchored to the button.
            showColorPicker(
              context: context,
              offset: const Offset(0, 8),
              color: ColorDerivative.fromColor(Colors.blue),
              onColorChanged: (value) {
                // Handle color change
              },
            );
          },
          child: const Text('Open Color Picker Popover'),
        ),
        const Gap(16),
        PrimaryButton(
          onPressed: () {
            // Show the color picker as a dialog with a title.
            showColorPickerDialog(
              context: context,
              title: const Text('Select Color'),
              onColorChanged: (value) {
                // Handle color change
              },
              color: ColorDerivative.fromColor(Colors.blue),
            );
          },
          child: const Text('Open Color Picker Dialog'),
        ),
      ],
    );
  }
}

```
