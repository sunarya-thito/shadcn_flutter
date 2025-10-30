---
title: "Class: ShadcnPointArcTween"
description: "A custom tween for animating points along an arc."
---

```dart
/// A custom tween for animating points along an arc.
///
/// This tween creates curved motion between two points, useful for
/// creating natural-looking animations.
class ShadcnPointArcTween extends Tween<Offset> {
  /// Creates a point arc tween.
  ShadcnPointArcTween({super.begin, super.end});
  /// Gets the center point of the arc between [begin] and [end].
  ///
  /// Returns `null` if either [begin] or [end] is null.
  ///
  /// The center is computed lazily and cached for performance.
  Offset? get center;
  /// Gets the radius of the arc between [begin] and [end].
  ///
  /// Returns `null` if either [begin] or [end] is null.
  ///
  /// The radius is the distance from the center to either endpoint.
  double? get radius;
  /// Gets the starting angle of the arc in radians.
  ///
  /// Returns `null` if either [begin] or [end] is null.
  ///
  /// Angle is measured clockwise from the positive x-axis.
  double? get beginAngle;
  /// Gets the ending angle of the arc in radians.
  ///
  /// Returns `null` if either [begin] or [end] is null.
  ///
  /// Angle is measured clockwise from the positive x-axis.
  double? get endAngle;
  set begin(Offset? value);
  set end(Offset? value);
  Offset lerp(double t);
}
```
