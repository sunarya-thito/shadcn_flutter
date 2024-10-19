import 'dart:math';

import 'package:shadcn_flutter/shadcn_flutter.dart';

class TimelineAnimationExample1 extends StatefulWidget {
  const TimelineAnimationExample1({super.key});

  @override
  State<TimelineAnimationExample1> createState() =>
      _TimelineAnimationExample1State();
}

class _TimelineAnimationExample1State extends State<TimelineAnimationExample1>
    with SingleTickerProviderStateMixin {
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
    lerp: Transformers.typeOffset,
  );
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
    lerp: Transformers.typeDouble,
  );

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
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
          offset: offsetTimeline.transform(controller.value),
          child: Transform.rotate(
            angle: rotationTimeline.transform(controller.value),
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
