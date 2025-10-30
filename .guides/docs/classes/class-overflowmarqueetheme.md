---
title: "Class: OverflowMarqueeTheme"
description: "Theme configuration for [OverflowMarquee] scrolling text displays."
---

```dart
/// Theme configuration for [OverflowMarquee] scrolling text displays.
///
/// Provides comprehensive styling and behavior options for marquee animations
/// including scroll direction, timing, fade effects, and animation curves.
/// All properties are optional and will fall back to default values when not specified.
///
/// Animation Properties:
/// - [direction]: Horizontal or vertical scrolling axis
/// - [duration]: Complete cycle time for one full scroll
/// - [delayDuration]: Pause time before restarting animation
/// - [curve]: Easing function for smooth animation transitions
///
/// Visual Properties:
/// - [step]: Pixel step size for scroll speed calculation
/// - [fadePortion]: Edge fade effect intensity (0.0 to 1.0)
///
/// Example:
/// ```dart
/// OverflowMarqueeTheme(
///   direction: Axis.horizontal,
///   duration: Duration(seconds: 5),
///   delayDuration: Duration(seconds: 1),
///   fadePortion: 0.1,
///   curve: Curves.easeInOut,
/// )
/// ```
class OverflowMarqueeTheme {
  /// Scrolling direction of the marquee.
  final Axis? direction;
  /// Duration of one full scroll cycle.
  final Duration? duration;
  /// Delay before scrolling starts again.
  final Duration? delayDuration;
  /// Step size used to compute scroll speed.
  final double? step;
  /// Portion of the child to fade at the edges.
  final double? fadePortion;
  /// Animation curve of the scroll.
  final Curve? curve;
  /// Creates an [OverflowMarqueeTheme].
  const OverflowMarqueeTheme({this.direction, this.duration, this.delayDuration, this.step, this.fadePortion, this.curve});
  /// Creates a copy of this theme with the given fields replaced.
  OverflowMarqueeTheme copyWith({ValueGetter<Axis?>? direction, ValueGetter<Duration?>? duration, ValueGetter<Duration?>? delayDuration, ValueGetter<double?>? step, ValueGetter<double?>? fadePortion, ValueGetter<Curve?>? curve});
  bool operator ==(Object other);
  int get hashCode;
}
```
