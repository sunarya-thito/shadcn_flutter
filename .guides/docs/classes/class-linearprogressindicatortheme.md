---
title: "Class: LinearProgressIndicatorTheme"
description: "Theme configuration for [LinearProgressIndicator] components."
---

```dart
/// Theme configuration for [LinearProgressIndicator] components.
///
/// Provides comprehensive visual styling properties for linear progress indicators
/// including colors, sizing, border radius, and visual effects. These properties
/// integrate with the design system and can be overridden at the widget level.
///
/// The theme supports advanced features like spark effects for enhanced visual
/// feedback and animation control for performance optimization scenarios.
class LinearProgressIndicatorTheme {
  /// The primary color of the progress indicator fill.
  ///
  /// Type: `Color?`. If null, uses theme's primary color. Applied to the
  /// filled portion that represents completion progress.
  final Color? color;
  /// The background color behind the progress indicator.
  ///
  /// Type: `Color?`. If null, uses a semi-transparent version of the primary color.
  /// Visible in the unfilled portion of the progress track.
  final Color? backgroundColor;
  /// The minimum height of the progress indicator.
  ///
  /// Type: `double?`. If null, defaults to 2.0 scaled by theme scaling factor.
  /// Ensures adequate visual presence while maintaining sleek appearance.
  final double? minHeight;
  /// The border radius of the progress indicator container.
  ///
  /// Type: `BorderRadiusGeometry?`. If null, uses BorderRadius.zero for sharp edges.
  /// Applied to both the track and progress fill for consistent styling.
  final BorderRadiusGeometry? borderRadius;
  /// Whether to display spark effects at the progress head.
  ///
  /// Type: `bool?`. If null, defaults to false. When enabled, shows a
  /// radial gradient spark effect at the leading edge of the progress fill.
  final bool? showSparks;
  /// Whether to disable smooth progress animations.
  ///
  /// Type: `bool?`. If null, defaults to false. When true, progress changes
  /// instantly without transitions for performance optimization.
  final bool? disableAnimation;
  /// Creates a [LinearProgressIndicatorTheme].
  ///
  /// All parameters are optional and can be null to use intelligent defaults
  /// based on the current theme configuration and design system values.
  ///
  /// Example:
  /// ```dart
  /// const LinearProgressIndicatorTheme(
  ///   color: Colors.blue,
  ///   backgroundColor: Colors.grey,
  ///   minHeight: 4.0,
  ///   borderRadius: BorderRadius.circular(2.0),
  ///   showSparks: true,
  /// );
  /// ```
  const LinearProgressIndicatorTheme({this.color, this.backgroundColor, this.minHeight, this.borderRadius, this.showSparks, this.disableAnimation});
  /// Returns a copy of this theme with the given fields replaced.
  LinearProgressIndicatorTheme copyWith({ValueGetter<Color?>? color, ValueGetter<Color?>? backgroundColor, ValueGetter<double?>? minHeight, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<bool?>? showSparks, ValueGetter<bool?>? disableAnimation});
  bool operator ==(Object other);
  int get hashCode;
}
```
