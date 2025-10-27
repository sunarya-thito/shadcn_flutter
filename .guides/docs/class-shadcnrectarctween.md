---
title: "Class: ShadcnRectArcTween"
description: "Reference for ShadcnRectArcTween"
---

```dart
class ShadcnRectArcTween extends RectTween {
  ShadcnRectArcTween({super.begin, super.end});
  ShadcnPointArcTween? get beginArc;
  ShadcnPointArcTween? get endArc;
  set begin(Rect? value);
  set end(Rect? value);
  Rect lerp(double t);
}
```
