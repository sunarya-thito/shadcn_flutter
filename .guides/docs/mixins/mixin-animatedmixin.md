---
title: "Mixin: AnimatedMixin"
description: "Reference for AnimatedMixin"
---

```dart
mixin AnimatedMixin on TickerProviderStateMixin {
  AnimatedProperty<T> createAnimatedProperty<T>(T value, PropertyLerp<T> lerp);
  void dispose();
  AnimatedProperty<int> createAnimatedInt(int value);
  AnimatedProperty<double> createAnimatedDouble(double value);
  AnimatedProperty<Color> createAnimatedColor(Color value);
}
```
