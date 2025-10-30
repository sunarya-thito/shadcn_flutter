---
title: "Class: HoverTheme"
description: "Theme configuration for hover-related widgets and behaviors."
---

```dart
/// Theme configuration for hover-related widgets and behaviors.
///
/// [HoverTheme] provides configurable durations and behaviors for hover
/// interactions throughout the application. It can be registered in the
/// component theme system to customize hover behavior globally.
///
/// Example:
/// ```dart
/// HoverTheme(
///   debounceDuration: Duration(milliseconds: 100),
///   hitTestBehavior: HitTestBehavior.opaque,
/// )
/// ```
class HoverTheme {
  /// Debounce duration for repeated hover events.
  ///
  /// When set, hover callbacks are throttled to fire at most once per this duration.
  final Duration? debounceDuration;
  /// Hit test behavior for hover detection.
  ///
  /// Determines how the widget participates in hit testing for mouse events.
  final HitTestBehavior? hitTestBehavior;
  /// Wait duration before showing hover feedback (e.g., tooltips).
  ///
  /// Delays the appearance of hover-triggered UI to avoid flashing on quick passes.
  final Duration? waitDuration;
  /// Minimum duration to keep hover feedback visible once shown.
  ///
  /// Prevents hover UI from disappearing too quickly.
  final Duration? minDuration;
  /// Duration for hover feedback show animations.
  final Duration? showDuration;
  /// Creates a [HoverTheme] with optional configuration values.
  const HoverTheme({this.debounceDuration, this.hitTestBehavior, this.waitDuration, this.minDuration, this.showDuration});
  /// Creates a copy of this theme with selectively replaced properties.
  ///
  /// Parameters are [ValueGetter] functions to allow setting values to `null`.
  HoverTheme copyWith({ValueGetter<Duration?>? debounceDuration, ValueGetter<HitTestBehavior?>? hitTestBehavior, ValueGetter<Duration?>? waitDuration, ValueGetter<Duration?>? minDuration, ValueGetter<Duration?>? showDuration});
  bool operator ==(Object other);
  int get hashCode;
}
```
