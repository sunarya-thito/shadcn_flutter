---
title: "Example: components/button/button_example_8.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample8 extends StatelessWidget {
  const ButtonExample8({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: [
        IconButton.primary(
          onPressed: () {},
          density: ButtonDensity.icon,
          icon: const Icon(Icons.add),
        ),
        IconButton.secondary(
          onPressed: () {},
          density: ButtonDensity.icon,
          icon: const Icon(Icons.add),
        ),
        IconButton.outline(
          onPressed: () {},
          density: ButtonDensity.icon,
          icon: const Icon(Icons.add),
        ),
        IconButton.ghost(
          onPressed: () {},
          density: ButtonDensity.icon,
          icon: const Icon(Icons.add),
        ),
        IconButton.text(
          onPressed: () {},
          density: ButtonDensity.icon,
          icon: const Icon(Icons.add),
        ),
        IconButton.destructive(
          onPressed: () {},
          density: ButtonDensity.icon,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}

```
