---
title: "Class: ControlledAnimation"
description: "Reference for ControlledAnimation"
---

```dart
class ControlledAnimation extends Animation<double> {
  ControlledAnimation(this._controller);
  TickerFuture forward(double to, [Curve? curve]);
  set value(double value);
  void addListener(VoidCallback listener);
  void addStatusListener(AnimationStatusListener listener);
  void removeListener(VoidCallback listener);
  void removeStatusListener(AnimationStatusListener listener);
  AnimationStatus get status;
  double get value;
}
```
