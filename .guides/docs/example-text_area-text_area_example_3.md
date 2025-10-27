---
title: "Example: components/text_area/text_area_example_3.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates a TextArea that expands both horizontally and vertically.

class TextAreaExample3 extends StatelessWidget {
  const TextAreaExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextArea(
      initialValue: 'Hello, World!',
      // Enable both horizontal and vertical growth based on content.
      expandableWidth: true,
      expandableHeight: true,
      // Larger starting dimensions to make the behavior obvious.
      initialWidth: 500,
      initialHeight: 300,
    );
  }
}

```
