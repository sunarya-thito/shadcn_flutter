---
title: "Example: components/animated_value_builder/animated_value_builder_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// AnimatedValueBuilder example: animating between colors.
///
/// This demonstrates how [AnimatedValueBuilder] can animate any value
/// given a `lerp` function. Here we animate a [Color] by using [Color.lerp]
/// as the interpolation function and switch the target color on button press.
class AnimatedValueBuilderExample1 extends StatefulWidget {
  const AnimatedValueBuilderExample1({super.key});

  @override
  State<AnimatedValueBuilderExample1> createState() =>
      _AnimatedValueBuilderExample1State();
}

class _AnimatedValueBuilderExample1State
    extends State<AnimatedValueBuilderExample1> {
  // A small palette to cycle through.
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
  ];
  // Index of the current target color.
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedValueBuilder(
          // The target value to animate towards.
          value: colors[index],
          // Duration of the tween between the previous and new value.
          duration: const Duration(seconds: 1),
          // The interpolation method between two colors.
          lerp: Color.lerp,
          // The builder exposes the current animated value on each frame.
          builder: (context, value, child) {
            return Container(
              width: 100,
              height: 100,
              color: value,
            );
          },
        ),
        const Gap(32),
        PrimaryButton(
          onPressed: () {
            setState(() {
              // Move to the next color cyclically to trigger a new animation.
              index = (index + 1) % colors.length;
            });
          },
          child: const Text('Change Color'),
        ),
      ],
    );
  }
}

```
