---
title: "Example: components/button/button_example_14.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample14 extends StatelessWidget {
  const ButtonExample14({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonGroup(
      children: [
        PrimaryButton(
          child: const Text('Primary'),
          onPressed: () {},
        ),
        SecondaryButton(
          child: const Text('Secondary'),
          onPressed: () {},
        ),
        DestructiveButton(
          child: const Text('Destructive'),
          onPressed: () {},
        ),
        OutlineButton(
          child: const Text('Outlined'),
          onPressed: () {},
        ),
        GhostButton(
          child: const Text('Ghost'),
          onPressed: () {},
        ),
        IconButton.primary(
          icon: const Icon(Icons.add),
          onPressed: () {},
        ),
      ],
    );
  }
}

```
