---
title: "Example: components/button/button_example_10.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample10 extends StatelessWidget {
  const ButtonExample10({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        PrimaryButton(
          size: ButtonSize.xSmall,
          onPressed: () {},
          child: const Text('Extra Small'),
        ),
        PrimaryButton(
          onPressed: () {},
          size: ButtonSize.small,
          child: const Text('Small'),
        ),
        PrimaryButton(
          size: ButtonSize.normal,
          onPressed: () {},
          child: const Text('Normal'),
        ),
        PrimaryButton(
          size: ButtonSize.large,
          onPressed: () {},
          child: const Text('Large'),
        ),
        PrimaryButton(
          size: ButtonSize.xLarge,
          onPressed: () {},
          child: const Text('Extra Large'),
        ),
      ],
    );
  }
}

```
