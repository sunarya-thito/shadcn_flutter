---
title: "Class: AnimationQueueController"
description: "Reference for AnimationQueueController"
---

```dart
class AnimationQueueController extends ChangeNotifier {
  AnimationQueueController([this._value = 0.0]);
  void push(AnimationRequest request, [bool queue = true]);
  set value(double value);
  double get value;
  bool get shouldTick;
  void tick(Duration delta);
}
```
