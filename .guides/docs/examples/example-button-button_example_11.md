---
title: "Example: components/button/button_example_11.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample11 extends StatelessWidget {
  const ButtonExample11({super.key});

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
          density: ButtonDensity.compact,
          child: const Text('Compact'),
        ),
        PrimaryButton(
          onPressed: () {},
          density: ButtonDensity.dense,
          child: const Text('Dense'),
        ),
        PrimaryButton(
          onPressed: () {},
          density: ButtonDensity.normal,
          child: const Text('Normal'),
        ),
        PrimaryButton(
          onPressed: () {},
          density: ButtonDensity.comfortable,
          child: const Text('Comfortable'),
        ),
        PrimaryButton(
          onPressed: () {},
          density: ButtonDensity.icon,
          child: const Text('Icon'),
        ),
        PrimaryButton(
          onPressed: () {},
          density: ButtonDensity.iconComfortable,
          child: const Text('Icon Comfortable'),
        ),
      ],
    );
  }
}

```
