---
title: "Class: TimelineAnimatable"
description: "Reference for TimelineAnimatable"
---

```dart
class TimelineAnimatable<T> extends Animatable<T> {
  final Duration duration;
  final TimelineAnimation<T> animation;
  TimelineAnimatable(this.duration, this.animation);
  T transform(double t);
}
```
