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
          icon: const Icon(LucideIcons.plus),
        ),
        IconButton.secondary(
          onPressed: () {},
          density: ButtonDensity.icon,
          icon: const Icon(LucideIcons.plus),
        ),
        IconButton.outline(
          onPressed: () {},
          density: ButtonDensity.icon,
          icon: const Icon(LucideIcons.plus),
        ),
        IconButton.ghost(
          onPressed: () {},
          density: ButtonDensity.icon,
          icon: const Icon(LucideIcons.plus),
        ),
        IconButton.text(
          onPressed: () {},
          density: ButtonDensity.icon,
          icon: const Icon(LucideIcons.plus),
        ),
        IconButton.destructive(
          onPressed: () {},
          density: ButtonDensity.icon,
          icon: const Icon(LucideIcons.plus),
        ),
      ],
    );
  }
}

```
