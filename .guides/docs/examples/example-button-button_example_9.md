---
title: "Example: components/button/button_example_9.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample9 extends StatelessWidget {
  const ButtonExample9({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        PrimaryButton(
          onPressed: () {},
          trailing: const Icon(Icons.add),
          child: const Text('Add'),
        ),
        SecondaryButton(
          onPressed: () {},
          trailing: const Icon(Icons.add),
          child: const Text('Add'),
        ),
        OutlineButton(
          onPressed: () {},
          trailing: const Icon(Icons.add),
          child: const Text('Add'),
        ),
        GhostButton(
          onPressed: () {},
          trailing: const Icon(Icons.add),
          child: const Text('Add'),
        ),
        TextButton(
          onPressed: () {},
          trailing: const Icon(Icons.add),
          child: const Text('Add'),
        ),
        DestructiveButton(
          onPressed: () {},
          trailing: const Icon(Icons.add),
          child: const Text('Add'),
        ),
      ],
    );
  }
}

```
