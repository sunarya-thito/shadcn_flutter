---
title: "Example: components/animated_value_builder/animated_value_builder_example_2.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// AnimatedValueBuilder example with an initial value and manual rebuild key.
///
/// Compared to the first example, this one:
/// - Specifies [initialValue] so the animation starts from transparent.
/// - Provides a [ValueKey] tied to [rebuildCount] to force the widget to
///   reset its internal animation state when desired.
class AnimatedValueBuilderExample2 extends StatefulWidget {
  const AnimatedValueBuilderExample2({super.key});

  @override
  State<AnimatedValueBuilderExample2> createState() =>
      _AnimatedValueBuilderExample2State();
}

class _AnimatedValueBuilderExample2State
    extends State<AnimatedValueBuilderExample2> {
  // The same color palette as before.
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
  ];
  // Current target index.
  int index = 0;
  // Changing this key forces the AnimatedValueBuilder to rebuild from scratch.
  int rebuildCount = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedValueBuilder(
          // When the key changes, Flutter treats this as a new widget
          // instance and reinitializes the animation.
          key: ValueKey(rebuildCount),
          value: colors[index],
          // Start from the same color but fully transparent, then animate in.
          initialValue: colors[index].withValues(alpha: 0),
          duration: const Duration(seconds: 1),
          lerp: Color.lerp,
          builder: (context, value, child) {
            return Container(
              width: 100,
              height: 100,
              color: value,
            );
          },
        ),
        const Gap(32),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryButton(
              onPressed: () {
                setState(() {
                  // Change the target color to trigger a new tween.
                  index = (index + 1) % colors.length;
                });
              },
```
