---
title: "Class: AnimationRunner"
description: "Manages the execution of a single animation step."
---

```dart
/// Manages the execution of a single animation step.
///
/// This class tracks the progress of an animation from a start value to an
/// end value over a specified duration using a curve.
///
/// ## Overview
///
/// [AnimationRunner] is used internally by [AnimationQueueController] to
/// execute individual animation steps. It tracks progress and computes
/// intermediate values.
///
/// ## Example
///
/// ```dart
/// final runner = AnimationRunner(
///   0.0, // from
///   1.0, // to
///   Duration(milliseconds: 200),
///   Curves.easeIn,
/// );
/// ```
class AnimationRunner {
  /// The starting value of the animation.
  final double from;
  /// The ending value of the animation.
  final double to;
  /// The total duration of the animation.
  final Duration duration;
  /// The easing curve applied to the animation.
  final Curve curve;
  /// Creates an animation runner with the specified parameters.
  ///
  /// ## Parameters
  ///
  /// * [from] - The starting value.
  /// * [to] - The target value.
  /// * [duration] - The animation duration.
  /// * [curve] - The easing curve.
  AnimationRunner(this.from, this.to, this.duration, this.curve);
}
```
