---
title: "Example: components/repeated_animation_builder/repeated_animation_builder_example_3.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class RepeatedAnimationBuilderExample3 extends StatefulWidget {
  const RepeatedAnimationBuilderExample3({super.key});

  @override
  State<RepeatedAnimationBuilderExample3> createState() =>
      _RepeatedAnimationBuilderExample3State();
}

class _RepeatedAnimationBuilderExample3State
    extends State<RepeatedAnimationBuilderExample3> {
  // Whether the animation is currently playing. Toggled by the button below.
  bool play = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RepeatedAnimationBuilder(
          // Drive play/pause from local state.
          play: play,
          start: const Offset(-100, 0),
          end: const Offset(100, 0),
          duration: const Duration(seconds: 1),
          // Provide a different reverse duration to show asymmetric timing.
          reverseDuration: const Duration(seconds: 5),
          // Use separate forward/reverse curves.
          curve: Curves.linear,
          reverseCurve: Curves.easeInOutCubic,
          // Ping-pong between start and end, reversing the direction each cycle.
          mode: RepeatMode.pingPongReverse,
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
        ),
        const Gap(24),
        PrimaryButton(
          onPressed: () {
            setState(() {
              // Toggle the 'play' flag, which starts/stops the animation.
              play = !play;
            });
          },
          child: Text(play ? 'Stop' : 'Play'),
        )
      ],
    );
  }
}

```
