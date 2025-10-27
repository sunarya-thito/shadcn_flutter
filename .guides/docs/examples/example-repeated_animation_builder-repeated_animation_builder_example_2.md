---
title: "Example: components/repeated_animation_builder/repeated_animation_builder_example_2.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class RepeatedAnimationBuilderExample2 extends StatelessWidget {
  const RepeatedAnimationBuilderExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return RepeatedAnimationBuilder(
      start: const Offset(-100, 0),
      end: const Offset(100, 0),
      duration: const Duration(seconds: 1),
      // Apply a non-linear easing curve.
      curve: Curves.easeInOutCubic,
      // Reverse mode plays forward to 'end', then backward to 'start', and repeats.
      mode: RepeatMode.reverse,
      builder: (context, value, child) {
        return Transform.translate(
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
