---
title: "Class: ShadcnRectArcTween"
description: "A custom tween for animating rectangles along an arc."
---

```dart
/// A custom tween for animating rectangles along an arc.
///
/// This tween creates more natural-looking animations for rectangles
/// by moving them along an arc path rather than a straight line.
class ShadcnRectArcTween extends RectTween {
  /// Creates a rectangle arc tween.
  ShadcnRectArcTween({super.begin, super.end});
  /// Gets the arc tween for the beginning point of the rectangle.
  ShadcnPointArcTween? get beginArc;
  /// Gets the arc tween for the ending point of the rectangle.
  ShadcnPointArcTween? get endArc;
  set begin(Rect? value);
  set end(Rect? value);
  Rect lerp(double t);
}
```
