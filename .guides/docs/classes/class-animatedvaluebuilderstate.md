---
title: "Class: AnimatedValueBuilderState"
description: "Reference for AnimatedValueBuilderState"
---

```dart
class AnimatedValueBuilderState<T> extends State<AnimatedValueBuilder<T>> with SingleTickerProviderStateMixin {
  void initState();
  T lerpedValue(T a, T b, double t);
  void didUpdateWidget(AnimatedValueBuilder<T> oldWidget);
  void dispose();
  Widget build(BuildContext context);
}
```
