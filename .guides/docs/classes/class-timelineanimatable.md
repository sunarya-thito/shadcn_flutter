---
title: "Class: TimelineAnimatable"
description: "An [Animatable] wrapper for [TimelineAnimation] with explicit duration."
---

```dart
/// An [Animatable] wrapper for [TimelineAnimation] with explicit duration.
///
/// This class adapts a [TimelineAnimation] to work with a specific total duration,
/// scaling the animation to fit within that time frame.
///
/// ## Type Parameters
///
/// * [T] - The type of value being animated.
///
/// ## Overview
///
/// [TimelineAnimatable] is typically created via [TimelineAnimation.drive] or
/// [TimelineAnimation.withTotalDuration] to bind a timeline to a controller.
///
/// ## Example
///
/// ```dart
/// final controller = AnimationController(
///   vsync: this,
///   duration: Duration(seconds: 2),
/// );
/// final animatable = timeline.drive(controller);
/// ```
class TimelineAnimatable<T> extends Animatable<T> {
  /// The total duration for this animatable.
  final Duration duration;
  /// The underlying timeline animation.
  final TimelineAnimation<T> animation;
  /// Creates a timeline animatable with the specified duration.
  ///
  /// ## Parameters
  ///
  /// * [duration] - The total duration for the animation.
  /// * [animation] - The timeline animation to wrap.
  TimelineAnimatable(this.duration, this.animation);
  T transform(double t);
}
```
