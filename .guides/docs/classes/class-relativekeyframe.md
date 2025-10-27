---
title: "Class: RelativeKeyframe"
description: "Reference for RelativeKeyframe"
---

```dart
class RelativeKeyframe<T> implements Keyframe<T> {
  final T target;
  final Duration duration;
  const RelativeKeyframe(this.duration, this.target);
  T compute(TimelineAnimation<T> timeline, int index, double t);
}
```
