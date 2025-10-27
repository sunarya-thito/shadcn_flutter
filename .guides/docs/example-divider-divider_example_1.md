---
title: "Example: components/divider/divider_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Horizontal dividers between list items.
///
/// Use [Divider] to visually separate vertically-stacked content.
class DividerExample1 extends StatelessWidget {
  const DividerExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Item 1'),
          Divider(),
          Text('Item 2'),
          Divider(),
          Text('Item 3'),
        ],
      ),
    );
  }
}

```
