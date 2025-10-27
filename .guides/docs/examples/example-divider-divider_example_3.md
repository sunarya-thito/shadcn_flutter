---
title: "Example: components/divider/divider_example_3.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Dividers with centered labels.
///
/// [Divider.child] can render text or other widgets inline with the rule.
class DividerExample3 extends StatelessWidget {
  const DividerExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Item 1'),
          Divider(
            child: Text('Divider'),
          ),
          Text('Item 2'),
          Divider(
            child: Text('Divider'),
          ),
          Text('Item 3'),
        ],
      ),
    );
  }
}

```
