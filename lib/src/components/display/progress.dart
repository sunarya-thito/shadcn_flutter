import 'package:shadcn_flutter/shadcn_flutter.dart';

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
  const ProgressTheme({
    this.color,
    this.backgroundColor,
    this.borderRadius,
    this.minHeight,
  });

  /// Creates a copy of this theme but with the given fields replaced with the new values.
  ProgressTheme copyWith({
    ValueGetter<Color?>? color,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<double?>? minHeight,
  }) {
    return ProgressTheme(
      color: color == null ? this.color : color(),
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      minHeight: minHeight == null ? this.minHeight : minHeight(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProgressTheme) return false;
    return other.color == color &&
        other.backgroundColor == backgroundColor &&
        other.borderRadius == borderRadius &&
        other.minHeight == minHeight;
  }

  @override
  int get hashCode => Object.hash(
        color,
        backgroundColor,
        borderRadius,
        minHeight,
      );
}

/// A linear progress indicator that visually represents task completion.
///
/// The Progress widget displays completion status as a horizontal bar that fills
/// from left to right based on the current progress value. Supports both
/// determinate progress (with specific values) and indeterminate progress
/// (continuous animation when value is null).
///
/// Built on top of [LinearProgressIndicator], this component provides enhanced
/// theming capabilities and integrates seamlessly with the design system.
/// Progress values are automatically normalized between configurable min/max
/// bounds with built-in validation to ensure values remain within range.
///
/// Key features:
/// - Flexible progress range with custom min/max values
/// - Automatic value normalization and validation
/// - Smooth animations with optional animation disable
/// - Comprehensive theming support via [ProgressTheme]
/// - Responsive scaling based on theme configuration
/// - Indeterminate progress support for unknown durations
///
/// Example:
/// ```dart
/// Progress(
///   progress: 0.65,
///   color: Colors.blue,
///   backgroundColor: Colors.grey.shade300,
/// );
/// ```
class Progress extends StatelessWidget {
  /// The current progress value within the specified range.
  ///
  /// Type: `double?`. If null, displays indeterminate progress animation.
  /// Must be between [min] and [max] values when provided. The widget
  /// automatically normalizes this value for display.
  final double? progress;

  /// The minimum value of the progress range.
  ///
  /// Type: `double`, default: `0.0`. Defines the starting point for
  /// progress calculation. Must be less than [max].
  final double min;

  /// The maximum value of the progress range.
  ///
  /// Type: `double`, default: `1.0`. Defines the completion point for
  /// progress calculation. Must be greater than [min].
  final double max;

  /// Whether to disable progress fill animations.
  ///
  /// Type: `bool`, default: `false`. When true, progress changes immediately
  /// without smooth transitions. Useful for performance optimization.
  final bool disableAnimation;

  /// The color of the progress indicator fill.
  ///
  /// Type: `Color?`. If null, uses the theme's progress color or
  /// the color specified in [ProgressTheme]. Overrides theme values.
  final Color? color;

  /// The background color of the progress track.
  ///
  /// Type: `Color?`. If null, uses the theme's background color or
  /// a semi-transparent version of the progress color. Overrides theme values.
  final Color? backgroundColor;

  /// The normalized progress value between 0.0 and 1.0.
  ///
  /// Type: `double?`. Returns null when [progress] is null (indeterminate).
  /// Automatically calculated by normalizing [progress] within the [min]-[max] range.
  ///
  /// Formula: `(progress - min) / (max - min)`
  double? get normalizedValue {
    if (progress == null) {
      return null;
    }
    return (progress! - min) / (max - min);
  }

  /// Creates a [Progress] indicator.
  ///
  /// The progress value must be between [min] and [max] when provided.
  /// If progress is null, the indicator shows indeterminate animation.
  ///
  /// Parameters:
  /// - [progress] (double?, optional): Current progress value or null for indeterminate
  /// - [min] (double, default: 0.0): Minimum progress value
  /// - [max] (double, default: 1.0): Maximum progress value
  /// - [disableAnimation] (bool, default: false): Whether to disable smooth transitions
  /// - [color] (Color?, optional): Progress fill color override
  /// - [backgroundColor] (Color?, optional): Progress track color override
  ///
  /// Throws:
  /// - [AssertionError] if progress is not between min and max values.
  ///
  /// Example:
  /// ```dart
  /// Progress(
  ///   progress: 75,
  ///   min: 0,
  ///   max: 100,
  ///   color: Colors.green,
  /// );
  /// ```
  const Progress({
    super.key,
    this.progress,
    this.min = 0.0,
    this.max = 1.0,
    this.disableAnimation = false,
    this.color,
    this.backgroundColor,
  }) : assert(progress == null || progress >= min && progress <= max,
            'Progress must be between min and max');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<ProgressTheme>(context);
    return LinearProgressIndicator(
      value: normalizedValue,
      backgroundColor: styleValue(
          defaultValue: backgroundColor,
          themeValue: compTheme?.backgroundColor),
      color: styleValue(
          themeValue: compTheme?.color, widgetValue: color, defaultValue: null),
      minHeight: styleValue(
          defaultValue: 8.0 * theme.scaling, themeValue: compTheme?.minHeight),
      borderRadius: styleValue(
          defaultValue: theme.borderRadiusSm,
          themeValue: compTheme?.borderRadius),
      disableAnimation: disableAnimation,
    );
  }
}
