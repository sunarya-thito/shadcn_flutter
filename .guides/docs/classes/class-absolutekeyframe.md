---
title: "Class: AbsoluteKeyframe"
description: "A keyframe that animates between explicit start and end values."
---

```dart
/// A keyframe that animates between explicit start and end values.
///
/// This keyframe interpolates from a specified [from] value to a [to] value
/// over its [duration], independent of previous keyframes.
///
/// ## Type Parameters
///
/// * [T] - The type of value to animate.
///
/// ## Overview
///
/// Use [AbsoluteKeyframe] when you want complete control over both the start
/// and end values of a keyframe, regardless of previous animation state.
///
/// ## Example
///
/// ```dart
/// // Animate from 0.0 to 1.0 over 200ms
/// final keyframe = AbsoluteKeyframe<double>(
///   Duration(milliseconds: 200),
///   0.0,
///   1.0,
/// );
/// ```
class AbsoluteKeyframe<T> implements Keyframe<T> {
  /// The starting value of the animation.
  final T from;
  /// The ending value of the animation.
  final T to;
  final Duration duration;
  /// Creates an absolute keyframe with explicit start and end values.
  ///
  /// ## Parameters
  ///
  /// * [duration] - How long to animate from [from] to [to].
  /// * [from] - The starting value.
  /// * [to] - The ending value.
  const AbsoluteKeyframe(this.duration, this.from, this.to);
  T compute(TimelineAnimation<T> timeline, int index, double t);
}
```
