---
title: "Class: TimelineTheme"
description: "Theme configuration for [Timeline] widgets."
---

```dart
/// Theme configuration for [Timeline] widgets.
///
/// Provides styling and layout defaults for timeline components including
/// column constraints, spacing, indicator appearance, and connector styling.
/// Used with [ComponentTheme] to apply consistent timeline styling across
/// an application while allowing per-instance customization.
///
/// Example:
/// ```dart
/// ComponentTheme<TimelineTheme>(
///   data: TimelineTheme(
///     timeConstraints: BoxConstraints(minWidth: 100, maxWidth: 150),
///     spacing: 20.0,
///     dotSize: 16.0,
///     color: Colors.blue,
///     rowGap: 24.0,
///   ),
///   child: MyTimelineWidget(),
/// );
/// ```
class TimelineTheme {
  /// Default constraints for the time column width.
  ///
  /// Controls the minimum and maximum width allocated for displaying time
  /// information in each timeline row. If null, individual Timeline widgets
  /// use their own constraints or a default of 120 logical pixels.
  final BoxConstraints? timeConstraints;
  /// Default horizontal spacing between timeline columns.
  ///
  /// Determines the gap between the time column, indicator column, and content
  /// column. If null, defaults to 16 logical pixels scaled by theme scaling factor.
  final double? spacing;
  /// Default diameter of timeline indicator dots.
  ///
  /// Controls the size of the circular (or square, based on theme radius) indicator
  /// that marks each timeline entry. If null, defaults to 12 logical pixels.
  final double? dotSize;
  /// Default thickness of connector lines between timeline entries.
  ///
  /// Controls the width of vertical lines that connect timeline indicators.
  /// If null, defaults to 2 logical pixels scaled by theme scaling factor.
  final double? connectorThickness;
  /// Default color for indicators and connectors when not specified per entry.
  ///
  /// Used as the fallback color for timeline dots and connecting lines when
  /// individual [TimelineData] entries don't specify their own color.
  final Color? color;
  /// Default vertical spacing between timeline rows.
  ///
  /// Controls the gap between each timeline entry in the vertical layout.
  /// If null, defaults to 16 logical pixels scaled by theme scaling factor.
  final double? rowGap;
  /// Creates a [TimelineTheme] with the specified styling options.
  ///
  /// All parameters are optional and will be merged with widget-level settings
  /// or system defaults when not specified.
  ///
  /// Parameters:
  /// - [timeConstraints] (BoxConstraints?, optional): Width constraints for time column.
  /// - [spacing] (double?, optional): Horizontal spacing between columns.
  /// - [dotSize] (double?, optional): Size of timeline indicator dots.
  /// - [connectorThickness] (double?, optional): Thickness of connecting lines.
  /// - [color] (Color?, optional): Default color for indicators and connectors.
  /// - [rowGap] (double?, optional): Vertical spacing between timeline entries.
  const TimelineTheme({this.timeConstraints, this.spacing, this.dotSize, this.connectorThickness, this.color, this.rowGap});
  /// Creates a copy of this theme with the given values replaced.
  ///
  /// Uses [ValueGetter] functions to allow conditional updates where
  /// null getters preserve the original value.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = originalTheme.copyWith(
  ///   spacing: () => 24.0,
  ///   color: () => Colors.green,
  /// );
  /// ```
  TimelineTheme copyWith({ValueGetter<BoxConstraints?>? timeConstraints, ValueGetter<double?>? spacing, ValueGetter<double?>? dotSize, ValueGetter<double?>? connectorThickness, ValueGetter<Color?>? color, ValueGetter<double?>? rowGap});
  bool operator ==(Object other);
  int get hashCode;
}
```
