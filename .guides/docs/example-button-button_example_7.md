---
title: "Example: components/button/button_example_7.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample7 extends StatelessWidget {
  const ButtonExample7({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        PrimaryButton(
          child: Text('Disabled'),
        ),
        SecondaryButton(
          child: Text('Disabled'),
        ),
        OutlineButton(
          child: Text('Disabled'),
        ),
        GhostButton(
          child: Text('Disabled'),
        ),
        TextButton(
          child: Text('Disabled'),
        ),
        DestructiveButton(
          child: Text('Disabled'),
        ),
      ],
    );
  }
}

```
