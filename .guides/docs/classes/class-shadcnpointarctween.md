---
title: "Class: ShadcnPointArcTween"
description: "Reference for ShadcnPointArcTween"
---

```dart
class ShadcnPointArcTween extends Tween<Offset> {
  ShadcnPointArcTween({super.begin, super.end});
  Offset? get center;
  double? get radius;
  double? get beginAngle;
  double? get endAngle;
  set begin(Offset? value);
  set end(Offset? value);
  Offset lerp(double t);
}
```
