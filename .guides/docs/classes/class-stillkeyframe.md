---
title: "Class: StillKeyframe"
description: "A keyframe that holds a constant value without animating."
---

```dart
/// A keyframe that holds a constant value without animating.
///
/// This keyframe maintains a static value for its duration. If [value] is `null`,
/// it uses the ending value from the previous keyframe.
///
/// ## Type Parameters
///
/// * [T] - The type of value to hold.
///
/// ## Overview
///
/// Use [StillKeyframe] to create pauses or delays in timeline animations where
/// the value remains constant for a period of time.
///
/// ## Example
///
/// ```dart
/// final timeline = TimelineAnimation<double>(
///   keyframes: [
///     AbsoluteKeyframe(Duration(milliseconds: 100), 0.0, 1.0),
///     StillKeyframe(Duration(milliseconds: 200)), // Hold at 1.0 for 200ms
///     RelativeKeyframe(Duration(milliseconds: 100), 0.0), // Back to 0.0
///   ],
/// );
/// ```
class StillKeyframe<T> implements Keyframe<T> {
  /// The value to hold, or `null` to use the previous keyframe's end value.
  final T? value;
  final Duration duration;
  /// Creates a still keyframe that holds a value.
  ///
  /// ## Parameters
  ///
  /// * [duration] - How long to hold the value.
  /// * [value] - The value to hold, or `null` to use the previous keyframe's end value.
  ///
  /// ## Notes
  ///
  /// If [value] is `null`, this keyframe must not be the first in the timeline.
  const StillKeyframe(this.duration, [this.value]);
  T compute(TimelineAnimation<T> timeline, int index, double t);
}
```
