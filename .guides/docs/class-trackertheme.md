---
title: "Class: TrackerTheme"
description: "Theme configuration for [Tracker] components."
---

```dart
/// Theme configuration for [Tracker] components.
///
/// [TrackerTheme] provides styling options for tracker components including
/// corner radius, spacing between segments, and segment height. It enables
/// consistent tracker styling across an application while allowing customization.
///
/// Used with [ComponentTheme] to apply theme values throughout the widget tree.
///
/// Example:
/// ```dart
/// ComponentTheme<TrackerTheme>(
///   data: TrackerTheme(
///     radius: 8.0,
///     gap: 2.0,
///     itemHeight: 40.0,
///   ),
///   child: MyTrackerWidget(),
/// );
/// ```
class TrackerTheme {
  /// Corner radius for the tracker container in logical pixels.
  ///
  /// Type: `double?`. Controls the rounding of tracker corners. If null,
  /// defaults to theme.radiusMd for consistent corner styling.
  final double? radius;
  /// Gap between individual tracker segments in logical pixels.
  ///
  /// Type: `double?`. Spacing between adjacent tracker segments. If null,
  /// defaults to theme.scaling * 2 for proportional spacing.
  final double? gap;
  /// Height of individual tracker segments in logical pixels.
  ///
  /// Type: `double?`. Controls the vertical size of tracker segments.
  /// If null, defaults to 32 logical pixels.
  final double? itemHeight;
  /// Creates a [TrackerTheme].
  ///
  /// All parameters are optional and will fall back to theme defaults
  /// when not provided.
  ///
  /// Parameters:
  /// - [radius] (double?, optional): Corner radius in pixels
  /// - [gap] (double?, optional): Spacing between segments in pixels
  /// - [itemHeight] (double?, optional): Height of segments in pixels
  ///
  /// Example:
  /// ```dart
  /// TrackerTheme(
  ///   radius: 12.0,
  ///   gap: 4.0,
  ///   itemHeight: 48.0,
  /// );
  /// ```
  const TrackerTheme({this.radius, this.gap, this.itemHeight});
  /// Creates a copy of this theme with the given values replaced.
  ///
  /// Returns a new [TrackerTheme] instance with the same values as this
  /// theme, except for any parameters that are explicitly provided. Use
  /// [ValueGetter] functions to specify new values.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = originalTheme.copyWith(
  ///   radius: () => 16.0,
  ///   itemHeight: () => 56.0,
  /// );
  /// ```
  TrackerTheme copyWith({ValueGetter<double?>? radius, ValueGetter<double?>? gap, ValueGetter<double?>? itemHeight});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
