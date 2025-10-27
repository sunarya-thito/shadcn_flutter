---
title: "Class: SafeLerp"
description: "Reference for SafeLerp"
---

```dart
class SafeLerp<T> {
  final T? Function(T? a, T? b, double t) nullableLerp;
  const SafeLerp(this.nullableLerp);
  T lerp(T a, T b, double t);
}
```
