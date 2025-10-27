import 'dart:math';

import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates TimelineAnimation by composing offset and rotation keyframes
// sampled by a shared controller.

class TimelineAnimationExample1 extends StatefulWidget {
  const TimelineAnimationExample1({super.key});

  @override
  State<TimelineAnimationExample1> createState() =>
      _TimelineAnimationExample1State();
}

class _TimelineAnimationExample1State extends State<TimelineAnimationExample1>
    with SingleTickerProviderStateMixin {
  // Timeline of Offset values combining absolute and relative keyframes.
  // AbsoluteKeyframe defines a start and end value over a fixed duration.
  // RelativeKeyframe appends a delta over the given duration.
  final TimelineAnimation<Offset> offsetTimeline = TimelineAnimation(
    keyframes: [
      const AbsoluteKeyframe(
        Duration(seconds: 1),
        Offset(-100, -100),
        Offset(100, -100),
      ),
      const RelativeKeyframe(
        Duration(seconds: 2),
        Offset(100, 100),
      ),
      const RelativeKeyframe(
        Duration(seconds: 1),
        Offset(-100, 100),
      ),
      const RelativeKeyframe(
        Duration(seconds: 2),
        Offset(-100, -100),
      ),
    ],
    // Provide a lerp function for Offset values.
    lerp: Transformers.typeOffset,
  );
  // A separate timeline animating rotation in radians. StillKeyframe pauses movement.
  final TimelineAnimation<double> rotationTimeline = TimelineAnimation(
    keyframes: [
      const AbsoluteKeyframe(
        Duration(seconds: 1),
        0,
        pi / 2,
      ),
      const StillKeyframe(
        Duration(seconds: 2),
      ),
      const RelativeKeyframe(
        Duration(seconds: 1),
        0,
      ),
      const StillKeyframe(
        Duration(seconds: 2),
      ),
    ],
    // Provide a lerp function for double values.
    lerp: Transformers.typeDouble,
  );

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      // Use the maximum duration across all timelines so they loop together.
      duration: timelineMaxDuration([
        offsetTimeline,
        rotationTimeline,
      ]),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.translate(
          // Sample the offset timeline using the shared controller.
          offset: offsetTimeline.transformWithController(controller),
          child: Transform.rotate(
            // Sample the rotation timeline using the shared controller.
            angle: rotationTimeline.transformWithController(controller),
            child: Container(
              width: 50,
              height: 50,
              color: Colors.blue,
            ),
          ),
        );
      },
    );
  }
}
