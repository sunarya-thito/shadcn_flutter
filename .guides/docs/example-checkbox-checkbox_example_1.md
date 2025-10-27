---
title: "Example: components/checkbox/checkbox_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Checkbox with two states (checked/unchecked).
///
/// Demonstrates controlling [Checkbox] via a local [CheckboxState]
/// and updating it from [onChanged].
class CheckboxExample1 extends StatefulWidget {
  const CheckboxExample1({super.key});

  @override
  State<CheckboxExample1> createState() => _CheckboxExample1State();
}

class _CheckboxExample1State extends State<CheckboxExample1> {
  // Start unchecked; toggle when the user taps the control.
  CheckboxState _state = CheckboxState.unchecked;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      state: _state,
      onChanged: (value) {
        setState(() {
          _state = value;
        });
      },
      // Optional label placed on the trailing side.
      trailing: const Text('Remember me'),
    );
  }
}

```
