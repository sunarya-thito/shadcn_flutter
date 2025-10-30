---
title: "Class: RelativeKeyframe"
description: "A keyframe that animates from the previous keyframe's end value to a target."
---

```dart
/// A keyframe that animates from the previous keyframe's end value to a target.
///
/// This keyframe automatically uses the ending value of the previous keyframe
/// as its starting point, animating to the specified [target] value.
///
/// ## Type Parameters
///
/// * [T] - The type of value to animate.
///
/// ## Overview
///
/// Use [RelativeKeyframe] for smooth transitions between keyframes without
/// explicitly specifying start values. If used as the first keyframe, it acts
/// as a still keyframe.
///
/// ## Example
///
/// ```dart
/// final timeline = TimelineAnimation<double>(
///   keyframes: [
///     AbsoluteKeyframe(Duration(milliseconds: 100), 0.0, 0.5),
///     RelativeKeyframe(Duration(milliseconds: 100), 1.0), // from 0.5 to 1.0
///   ],
/// );
/// ```
class RelativeKeyframe<T> implements Keyframe<T> {
  /// The target value to animate to from the previous keyframe's end.
  final T target;
  final Duration duration;
  /// Creates a relative keyframe that animates to the target value.
  ///
  /// ## Parameters
  ///
  /// * [duration] - How long to animate to [target].
  /// * [target] - The ending value for this keyframe.
  const RelativeKeyframe(this.duration, this.target);
  T compute(TimelineAnimation<T> timeline, int index, double t);
}
```
