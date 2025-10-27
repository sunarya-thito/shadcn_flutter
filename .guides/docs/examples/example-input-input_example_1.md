---
title: "Example: components/input/input_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class InputExample1 extends StatelessWidget {
  const InputExample1({super.key});

  @override
  Widget build(BuildContext context) {
    // Basic text input using shadcn_flutter's TextField.
    // placeholder is rendered inside the input when it's empty.
    return const TextField(
      placeholder: Text('Enter your name'),
    );
  }
}

```
