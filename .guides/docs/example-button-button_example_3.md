---
title: "Example: components/button/button_example_3.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Outline button.
///
/// Uses an outlined border for a minimal visual weight.
class ButtonExample3 extends StatelessWidget {
  const ButtonExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: () {},
      child: const Text('Outlined'),
    );
  }
}

```
