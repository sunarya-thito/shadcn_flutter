---
title: "Example: components/button/button_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Primary button.
///
/// Use for the main call-to-action on a screen.
class ButtonExample1 extends StatelessWidget {
  const ButtonExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {},
      child: const Text('Primary'),
    );
  }
}

```
