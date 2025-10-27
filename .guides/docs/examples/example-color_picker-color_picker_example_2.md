---
title: "Example: components/color_picker/color_picker_example_2.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ColorPickerExample2 extends StatelessWidget {
  const ColorPickerExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () async {
        // Screen color picker: lets the user sample any on-screen color.
        final history = ColorHistoryStorage.of(context);
        final result = await pickColorFromScreen(context, history);
        if (result != null && context.mounted) {
          // Show a toast with the hex value and a preview swatch.
          showToast(
            context: context,
            builder: (context, overlay) {
              return SurfaceCard(
                  child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Color: ${colorToHex(result)}'),
                  const Gap(16),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: result,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ));
            },
          );
        }
      },
      child: const Text('Pick Color'),
    );
  }
}

```
