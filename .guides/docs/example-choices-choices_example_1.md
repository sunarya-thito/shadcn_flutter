---
title: "Example: components/choices/choices_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ChoicesExample1 extends StatefulWidget {
  const ChoicesExample1({super.key});

  @override
  State<ChoicesExample1> createState() => _ChoicesExample1State();
}

class _ChoicesExample1State extends State<ChoicesExample1> {
  @override
  Widget build(BuildContext context) {
    // MultipleChoice provides a context for building a set of mutually-exclusive
    // or multi-selectable options, depending on the configuration. This stub
    // example keeps an empty Column to demonstrate the container itself.
    // In practical examples, you would place choice items (e.g., ChoiceTile,
    // Checkboxes/Radio or custom widgets) inside the child.
    return const MultipleChoice(
      child: Column(
        children: [],
      ),
    );
  }
}

```
