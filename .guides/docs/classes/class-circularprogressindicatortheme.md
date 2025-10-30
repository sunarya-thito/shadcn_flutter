---
title: "Class: CircularProgressIndicatorTheme"
description: "Theme configuration for [CircularProgressIndicator] components."
---

```dart
/// Theme configuration for [CircularProgressIndicator] components.
///
/// Provides visual styling properties for circular progress indicators including
/// colors, sizing, and stroke characteristics. These properties integrate with
/// the design system and can be overridden at the widget level.
///
/// All theme values respect the current theme's scaling factor and color scheme
/// for consistent visual presentation across different screen densities and themes.
class CircularProgressIndicatorTheme {
  /// The primary color of the progress indicator arc.
  ///
  /// Type: `Color?`. If null, uses theme's primary color or background color
  /// when [onSurface] is true. Applied to the filled portion of the circular track.
  final Color? color;
  /// The background color of the progress indicator track.
  ///
  /// Type: `Color?`. If null, uses a semi-transparent version of the primary color.
  /// Visible in the unfilled portion of the circular track.
  final Color? backgroundColor;
  /// The diameter size of the circular progress indicator.
  ///
  /// Type: `double?`. If null, derives size from current icon theme size minus padding.
  /// Determines the overall dimensions of the circular progress display.
  final double? size;
  /// The width of the progress indicator stroke.
  ///
  /// Type: `double?`. If null, calculates as size/12 for proportional appearance.
  /// Controls the thickness of both the progress arc and background track.
  final double? strokeWidth;
  /// Creates a [CircularProgressIndicatorTheme].
  ///
  /// All parameters are optional and can be null to use intelligent defaults
  /// based on the current theme configuration and icon context.
  ///
  /// Example:
  /// ```dart
  /// const CircularProgressIndicatorTheme(
  ///   color: Colors.blue,
  ///   backgroundColor: Colors.grey,
  ///   size: 32.0,
  ///   strokeWidth: 3.0,
  /// );
  /// ```
  const CircularProgressIndicatorTheme({this.color, this.backgroundColor, this.size, this.strokeWidth});
  /// Creates a copy of this theme with the given fields replaced.
  CircularProgressIndicatorTheme copyWith({ValueGetter<Color?>? color, ValueGetter<Color?>? backgroundColor, ValueGetter<double?>? size, ValueGetter<double?>? strokeWidth});
  bool operator ==(Object other);
  int get hashCode;
}
```
