---
title: "Class: TimelineAnimation"
description: "Reference for TimelineAnimation"
---

```dart
class TimelineAnimation<T> extends Animatable<T> {
  static T defaultLerp<T>(T a, T b, double t);
  final PropertyLerp<T> lerp;
  final Duration totalDuration;
  final List<Keyframe<T>> keyframes;
  factory TimelineAnimation({PropertyLerp<T>? lerp, required List<Keyframe<T>> keyframes});
  TimelineAnimatable<T> drive(AnimationController controller);
  T transformWithController(AnimationController controller);
  TimelineAnimatable<T> withTotalDuration(Duration duration);
  T transform(double t);
}
```
