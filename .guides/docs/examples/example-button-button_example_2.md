---
title: "Example: components/button/button_example_2.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Secondary button.
///
/// A lower-emphasis action compared to [PrimaryButton].
class ButtonExample2 extends StatelessWidget {
  const ButtonExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      onPressed: () {},
      child: const Text('Secondary'),
    );
  }
}

```
