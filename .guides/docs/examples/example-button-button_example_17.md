---
title: "Example: components/button/button_example_17.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample17 extends StatelessWidget {
  const ButtonExample17({super.key});

  @override
  Widget build(BuildContext context) {
    return Button(
      style: const ButtonStyle.primary()
          .withBackgroundColor(color: Colors.red, hoverColor: Colors.purple)
      .withForegroundColor(color: Colors.white)
      .withBorderRadius(hoverBorderRadius: BorderRadius.circular(16)),
      onPressed: () {},
      leading: const Icon(Icons.sunny),
      child: const Text('Custom Button'),
    );
  }
}

```
