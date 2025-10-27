---
title: "Class: IntervalDuration"
description: "A custom curve that creates time-based intervals within an animation duration."
---

```dart
/// A custom curve that creates time-based intervals within an animation duration.
///
/// [IntervalDuration] allows you to create animations that start after a delay
/// or end before the full duration completes, using actual [Duration] values
/// instead of normalized progress values (0.0-1.0).
///
/// This is particularly useful for staggered animations or when you need precise
/// timing control based on real time intervals rather than animation progress percentages.
///
/// Example:
/// ```dart
/// // Animation that starts after 500ms delay and ends 200ms early
/// IntervalDuration(
///   start: Duration(milliseconds: 500),
///   end: Duration(milliseconds: 1800), // out of 2000ms total
///   duration: Duration(milliseconds: 2000),
///   curve: Curves.easeInOut,
/// );
/// ```
class IntervalDuration extends Curve {
  /// The duration after which the animation should start.
  ///
  /// If null, animation starts immediately. When specified, the animation
  /// remains at progress 0.0 until this duration elapses within the total duration.
  final Duration? start;
  /// The duration at which the animation should end.
  ///
  /// If null, animation continues until the full duration. When specified,
  /// the animation reaches progress 1.0 at this point and holds that value.
  final Duration? end;
  /// The total duration of the animation timeline.
  ///
  /// This represents the complete animation duration within which the start
  /// and end intervals operate. Must be greater than both start and end durations.
  final Duration duration;
  /// Optional curve to apply to the active portion of the animation.
  ///
  /// This curve is applied to the progress between start and end intervals,
  /// allowing for easing effects during the active animation period.
  final Curve? curve;
  /// Creates an [IntervalDuration] curve with explicit timing intervals.
  ///
  /// Parameters:
  /// - [start] (Duration?, optional): When animation should begin within total duration.
  /// - [end] (Duration?, optional): When animation should complete within total duration.
  /// - [duration] (Duration, required): Total animation timeline duration.
  /// - [curve] (Curve?, optional): Easing curve for the active animation portion.
  ///
  /// Example:
  /// ```dart
  /// IntervalDuration(
  ///   start: Duration(milliseconds: 300),
  ///   end: Duration(milliseconds: 700),
  ///   duration: Duration(seconds: 1),
  ///   curve: Curves.easeOut,
  /// );
  /// ```
  const IntervalDuration({this.start, this.end, required this.duration, this.curve});
  /// Creates an [IntervalDuration] with delay-based timing.
  ///
  /// This factory constructor makes it easier to specify delays from the start
  /// and end of the animation rather than absolute timing positions.
  ///
  /// Parameters:
  /// - [startDelay] (Duration?, optional): Delay before animation starts.
  /// - [endDelay] (Duration?, optional): How much earlier animation should end.
  /// - [duration] (Duration, required): Base animation duration.
  ///
  /// The total timeline duration becomes [duration] + [startDelay] + [endDelay].
  ///
  /// Example:
  /// ```dart
  /// // Animation with 200ms start delay and ending 100ms early
  /// IntervalDuration.delayed(
  ///   startDelay: Duration(milliseconds: 200),
  ///   endDelay: Duration(milliseconds: 100),
  ///   duration: Duration(seconds: 1),
  /// );
  /// ```
  factory IntervalDuration.delayed({Duration? startDelay, Duration? endDelay, required Duration duration});
  double transform(double t);
}
```
