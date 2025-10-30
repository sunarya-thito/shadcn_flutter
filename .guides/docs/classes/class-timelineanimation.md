---
title: "Class: TimelineAnimation"
description: "A timeline-based animation built from multiple keyframes."
---

```dart
/// A timeline-based animation built from multiple keyframes.
///
/// This class extends [Animatable]`<T>` and orchestrates complex animations by
/// sequencing multiple [Keyframe]s. Each keyframe defines a segment of the
/// animation with its own duration and interpolation strategy.
///
/// ## Type Parameters
///
/// * [T] - The type of value being animated.
///
/// ## Overview
///
/// Use [TimelineAnimation] to create sophisticated multi-stage animations.
/// Keyframes can be absolute, relative, or still, allowing for diverse
/// animation patterns. The timeline automatically calculates total duration
/// from all keyframes.
///
/// ## Example
///
/// ```dart
/// final timeline = TimelineAnimation<double>(
///   lerp: Transformers.typeDouble,
///   keyframes: [
///     AbsoluteKeyframe(Duration(milliseconds: 100), 0.0, 1.0),
///     StillKeyframe(Duration(milliseconds: 50)),
///     RelativeKeyframe(Duration(milliseconds: 100), 0.5),
///   ],
/// );
/// ```
class TimelineAnimation<T> extends Animatable<T> {
  /// Default lerp function that works with numeric types.
  ///
  /// This function performs basic arithmetic interpolation. It assumes the
  /// type supports addition, subtraction, and multiplication operators.
  ///
  /// ## Type Parameters
  ///
  /// * [T] - The type to interpolate (must support arithmetic operations).
  ///
  /// ## Parameters
  ///
  /// * [a] - The starting value.
  /// * [b] - The ending value.
  /// * [t] - The interpolation factor (0.0 to 1.0).
  ///
  /// ## Returns
  ///
  /// The interpolated value.
  static T defaultLerp<T>(T a, T b, double t);
  /// The interpolation function used for this timeline.
  final PropertyLerp<T> lerp;
  /// The total duration of all keyframes combined.
  final Duration totalDuration;
  /// The list of keyframes that make up this timeline.
  final List<Keyframe<T>> keyframes;
  /// Creates a timeline animation from a list of keyframes.
  ///
  /// ## Parameters
  ///
  /// * [lerp] - Optional interpolation function. Uses [defaultLerp] if not provided.
  /// * [keyframes] - The list of keyframes defining the animation. Must not be empty.
  ///
  /// ## Returns
  ///
  /// A new [TimelineAnimation] with calculated total duration.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final timeline = TimelineAnimation<Color>(
  ///   lerp: Transformers.typeColor,
  ///   keyframes: [
  ///     AbsoluteKeyframe(Duration(milliseconds: 300), Colors.red, Colors.blue),
  ///     RelativeKeyframe(Duration(milliseconds: 200), Colors.green),
  ///   ],
  /// );
  /// ```
  factory TimelineAnimation({PropertyLerp<T>? lerp, required List<Keyframe<T>> keyframes});
  /// Binds this timeline to an [AnimationController].
  ///
  /// ## Parameters
  ///
  /// * [controller] - The animation controller to drive this timeline.
  ///   Must have a non-null duration.
  ///
  /// ## Returns
  ///
  /// A [TimelineAnimatable] that can be used with the controller.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final controller = AnimationController(
  ///   vsync: this,
  ///   duration: Duration(seconds: 1),
  /// );
  /// final animatable = timeline.drive(controller);
  /// ```
  TimelineAnimatable<T> drive(AnimationController controller);
  /// Transforms the timeline using the controller's current value.
  ///
  /// This is a convenience method that combines [drive] and [Animatable.transform].
  ///
  /// ## Parameters
  ///
  /// * [controller] - The animation controller to read the value from.
  ///
  /// ## Returns
  ///
  /// The current value of type [T] based on the controller's progress.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final value = timeline.transformWithController(controller);
  /// ```
  T transformWithController(AnimationController controller);
  /// Creates a [TimelineAnimatable] with the specified total duration.
  ///
  /// ## Parameters
  ///
  /// * [duration] - The desired total duration for this timeline.
  ///
  /// ## Returns
  ///
  /// A [TimelineAnimatable] that scales this timeline to the given duration.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Timeline with natural duration of 500ms
  /// final timeline = TimelineAnimation<double>(...);
  ///
  /// // Scale to 2 seconds
  /// final animatable = timeline.withTotalDuration(Duration(seconds: 2));
  /// ```
  TimelineAnimatable<T> withTotalDuration(Duration duration);
  T transform(double t);
}
```
