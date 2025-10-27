---
title: "Class: ProgressTheme"
description: "Theme configuration for [Progress] components."
---

```dart
/// Theme configuration for [Progress] components.
///
/// Provides visual styling properties for progress indicators including colors,
/// border radius, and sizing constraints. These properties can be overridden
/// at the widget level or applied globally via [ComponentTheme].
///
/// The theme integrates seamlessly with the design system by leveraging
/// theme scaling factors and color schemes for consistent visual presentation.
class ProgressTheme {
  /// The foreground color of the progress indicator.
  ///
  /// Type: `Color?`. If null, uses the default progress color from theme.
  /// Applied to the filled portion that shows completion progress.
  final Color? color;
  /// The background color behind the progress indicator.
  ///
  /// Type: `Color?`. If null, uses a semi-transparent version of the progress color.
  /// Visible in the unfilled portion of the progress track.
  final Color? backgroundColor;
  /// The border radius of the progress indicator container.
  ///
  /// Type: `BorderRadiusGeometry?`. If null, uses theme's small border radius.
  /// Applied to both the track and the progress fill for consistent styling.
  final BorderRadiusGeometry? borderRadius;
  /// The minimum height of the progress indicator.
  ///
  /// Type: `double?`. If null, defaults to 8.0 scaled by theme scaling factor.
  /// Ensures adequate visual presence while maintaining proportional sizing.
  final double? minHeight;
  /// Creates a [ProgressTheme].
  ///
  /// All parameters are optional and can be null to use default values
  /// derived from the current theme configuration.
  ///
  /// Example:
  /// ```dart
  /// const ProgressTheme(
  ///   color: Colors.blue,
  ///   backgroundColor: Colors.grey,
  ///   borderRadius: BorderRadius.circular(4.0),
  ///   minHeight: 6.0,
  /// );
  /// ```
  const ProgressTheme({this.color, this.backgroundColor, this.borderRadius, this.minHeight});
  /// Creates a copy of this theme but with the given fields replaced with the new values.
  ProgressTheme copyWith({ValueGetter<Color?>? color, ValueGetter<Color?>? backgroundColor, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<double?>? minHeight});
  bool operator ==(Object other);
  int get hashCode;
}
```
