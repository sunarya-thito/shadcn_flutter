---
title: "Class: AbsoluteKeyframe"
description: "Reference for AbsoluteKeyframe"
---

```dart
class AbsoluteKeyframe<T> implements Keyframe<T> {
  final T from;
  final T to;
  final Duration duration;
  const AbsoluteKeyframe(this.duration, this.from, this.to);
  T compute(TimelineAnimation<T> timeline, int index, double t);
}
```
