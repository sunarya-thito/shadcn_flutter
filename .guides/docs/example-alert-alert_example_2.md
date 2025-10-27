---
title: "Example: components/alert/alert_example_2.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Destructive Alert example.
///
/// Demonstrates using the `destructive` style via the named constructor
/// [Alert.destructive], which is suitable for critical or dangerous states.
class AlertExample2 extends StatelessWidget {
  const AlertExample2({super.key});

  @override
  Widget build(BuildContext context) {
    // Destructive styling typically emphasizes caution to the user.
    return const Alert.destructive(
      title: Text('Alert title'),
      content: Text('This is alert content.'),
      trailing: Icon(Icons.dangerous_outlined),
    );
  }
}

```
