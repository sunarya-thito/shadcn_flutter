---
title: "Class: Keyframe"
description: "Reference for Keyframe"
---

```dart
abstract class Keyframe<T> {
  Duration get duration;
  T compute(TimelineAnimation<T> timeline, int index, double t);
}
```
