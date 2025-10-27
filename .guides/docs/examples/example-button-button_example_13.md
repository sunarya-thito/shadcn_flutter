---
title: "Example: components/button/button_example_13.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample13 extends StatelessWidget {
  const ButtonExample13({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        PrimaryButton(
          onPressed: () {},
          shape: ButtonShape.circle,
          child: const Icon(Icons.add),
        ),
        PrimaryButton(
          onPressed: () {},
          shape: ButtonShape.rectangle,
          child: const Text('Rectangle'),
        ),
      ],
    );
  }
}

```
