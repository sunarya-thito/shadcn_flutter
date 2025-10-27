---
title: "Example: components/text_area/text_area_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates a TextArea that expands vertically with its content.

class TextAreaExample1 extends StatelessWidget {
  const TextAreaExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextArea(
      initialValue: 'Hello, World!',
      // Let the text area grow vertically with content up to constraints.
      expandableHeight: true,
      // Start with a taller initial height to show multiple lines.
      initialHeight: 300,
    );
  }
}

```
