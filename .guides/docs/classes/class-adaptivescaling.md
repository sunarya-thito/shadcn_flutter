---
title: "Class: AdaptiveScaling"
description: "Reference for AdaptiveScaling"
---

```dart
class AdaptiveScaling {
  static const AdaptiveScaling desktop = AdaptiveScaling();
  static const AdaptiveScaling mobile = AdaptiveScaling(1.25);
  final double radiusScaling;
  final double sizeScaling;
  final double textScaling;
  const AdaptiveScaling([double scaling = 1]);
  const AdaptiveScaling.only({this.radiusScaling = 1, this.sizeScaling = 1, this.textScaling = 1});
  ThemeData scale(ThemeData theme);
  static AdaptiveScaling lerp(AdaptiveScaling a, AdaptiveScaling b, double t);
}
```
