---
title: "Example: components/repeated_animation_builder/repeated_animation_builder_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class RepeatedAnimationBuilderExample1 extends StatelessWidget {
  const RepeatedAnimationBuilderExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return RepeatedAnimationBuilder(
      // Animate a value from 'start' to 'end' and repeat.
      // The builder below receives the animated Offset each tick.
      start: const Offset(-100, 0),
      end: const Offset(100, 0),
      // One second per run from start to end.
      duration: const Duration(seconds: 1),
      builder: (context, value, child) {
        return Transform.translate(
          // Move a square horizontally based on the current animated value.
          offset: value,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
        );
      },
    );
  }
}

```
