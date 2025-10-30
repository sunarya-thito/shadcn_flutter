---
title: "Class: Keyframe"
description: "An abstract interface for keyframes in timeline animations."
---

```dart
/// An abstract interface for keyframes in timeline animations.
///
/// A keyframe defines how to compute a value at a specific point in a
/// timeline animation. Different implementations provide different interpolation
/// strategies (absolute, relative, or static).
///
/// ## Type Parameters
///
/// * [T] - The type of value this keyframe produces.
///
/// ## Overview
///
/// Use [Keyframe] implementations like [AbsoluteKeyframe], [RelativeKeyframe],
/// or [StillKeyframe] to build complex timeline animations with
/// [TimelineAnimation].
///
/// See also:
///
/// * [AbsoluteKeyframe] - Animates between explicit start and end values.
/// * [RelativeKeyframe] - Animates from the previous keyframe's end value.
/// * [StillKeyframe] - Holds a value without animating.
abstract class Keyframe<T> {
  /// The duration of this keyframe.
  ///
  /// ## Returns
  ///
  /// The time this keyframe takes to complete.
  Duration get duration;
  /// Computes the value for this keyframe at the given progress.
  ///
  /// ## Parameters
  ///
  /// * [timeline] - The parent timeline animation.
  /// * [index] - The index of this keyframe in the timeline.
  /// * [t] - The local progress through this keyframe (0.0 to 1.0).
  ///
  /// ## Returns
  ///
  /// The computed value of type [T] at the given progress.
  T compute(TimelineAnimation<T> timeline, int index, double t);
}
```
