---
title: "Example: components/linear_progress/linear_progress_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class LinearProgressExample1 extends StatelessWidget {
  const LinearProgressExample1({super.key});

  @override
  Widget build(BuildContext context) {
    // Indeterminate linear progress indicator with a fixed width.
    // When no `value` is provided, it displays an animated looping bar.
    return const SizedBox(
      width: 200,
      child: LinearProgressIndicator(),
    );
  }
}

```
