import 'package:flutter/material.dart' as mat;

import '../../../shadcn_flutter.dart';

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
  const CircularProgressIndicatorTheme({
    this.color,
    this.backgroundColor,
    this.size,
    this.strokeWidth,
  });

  /// Creates a copy of this theme with the given fields replaced.
  CircularProgressIndicatorTheme copyWith({
    ValueGetter<Color?>? color,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<double?>? size,
    ValueGetter<double?>? strokeWidth,
  }) {
    return CircularProgressIndicatorTheme(
      color: color == null ? this.color : color(),
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      size: size == null ? this.size : size(),
      strokeWidth: strokeWidth == null ? this.strokeWidth : strokeWidth(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CircularProgressIndicatorTheme &&
        other.color == color &&
        other.backgroundColor == backgroundColor &&
        other.size == size &&
        other.strokeWidth == strokeWidth;
  }

  @override
  int get hashCode => Object.hash(
        color,
        backgroundColor,
        size,
        strokeWidth,
      );
}

/// A circular progress indicator that displays task completion as a rotating arc.
///
/// The CircularProgressIndicator provides both determinate and indeterminate
/// progress visualization in a compact circular format. When a specific progress
/// value is provided, it shows completion as a filled arc. When value is null,
/// it displays a continuous spinning animation.
///
/// Built as a wrapper around Flutter's native CircularProgressIndicator with
/// enhanced theming capabilities and integration with the shadcn design system.
/// Automatically adapts sizing based on the current [IconTheme] context while
/// providing manual size override options.
///
/// Key features:
/// - Determinate and indeterminate progress modes
/// - Automatic sizing based on icon context with manual overrides
/// - Smooth value animations with configurable duration
/// - Surface mode for display on colored backgrounds
/// - Comprehensive theming via [CircularProgressIndicatorTheme]
/// - Performance-optimized rendering with [RepaintBoundary]
///
/// The component intelligently calculates default colors and sizing based on
/// the current theme and icon context, ensuring consistent visual integration.
///
/// Example:
/// ```dart
/// CircularProgressIndicator(
///   value: 0.75,
///   size: 32.0,
///   color: Colors.blue,
/// );
/// ```
class CircularProgressIndicator extends StatelessWidget {
  /// The progress completion value between 0.0 and 1.0.
  ///
  /// Type: `double?`. If null, displays indeterminate spinning animation.
  /// When provided, shows progress as a filled arc from 0% to value*100%.
  final double? value;

  /// The explicit diameter size of the progress indicator.
  ///
  /// Type: `double?`. If null, derives size from current icon theme size
  /// minus theme scaling padding. Overrides theme and automatic sizing.
  final double? size;

  /// The primary color of the progress arc.
  ///
  /// Type: `Color?`. If null, uses theme color or background color when
  /// [onSurface] is true. Overrides theme configuration.
  final Color? color;

  /// The background color of the progress track.
  ///
  /// Type: `Color?`. If null, uses a semi-transparent version of the
  /// primary color. Overrides theme configuration.
  final Color? backgroundColor;

  /// The width of the progress stroke line.
  ///
  /// Type: `double?`. If null, calculates proportionally as size/12.
  /// Controls the thickness of both progress and background arcs.
  final double? strokeWidth;

  /// The duration for smooth progress value transitions.
  ///
  /// Type: `Duration`, default: [kDefaultDuration]. Only applied when
  /// [animated] is true and [value] is provided for determinate progress.
  final Duration duration;

  /// Whether to animate progress value changes.
  ///
  /// Type: `bool`, default: `true`. When false, progress changes instantly.
  /// When true with determinate value, uses [AnimatedValueBuilder] for smooth transitions.
  final bool animated;

  /// Whether the indicator is displayed on a colored surface.
  ///
  /// Type: `bool`, default: `false`. When true, uses background color instead
  /// of primary color for better visibility on colored backgrounds.
  final bool onSurface;

  /// Creates a [CircularProgressIndicator].
  ///
  /// The component automatically handles both determinate and indeterminate modes
  /// based on whether [value] is provided. Size and colors adapt intelligently
  /// based on theme context unless explicitly overridden.
  ///
  /// Parameters:
  /// - [value] (double?, optional): Progress completion (0.0-1.0) or null for indeterminate
  /// - [size] (double?, optional): Explicit diameter size override
  /// - [color] (Color?, optional): Primary progress arc color override
  /// - [backgroundColor] (Color?, optional): Background track color override
  /// - [strokeWidth] (double?, optional): Progress stroke thickness override
  /// - [duration] (Duration, default: kDefaultDuration): Animation duration for value changes
  /// - [animated] (bool, default: true): Whether to animate progress transitions
  /// - [onSurface] (bool, default: false): Whether displayed on colored background
  ///
  /// Example:
  /// ```dart
  /// CircularProgressIndicator(
  ///   value: 0.6,
  ///   size: 24.0,
  ///   strokeWidth: 2.0,
  ///   animated: true,
  /// );
  /// ```
  const CircularProgressIndicator({
    super.key,
    this.value,
    this.size,
    this.color,
    this.backgroundColor,
    this.strokeWidth,
    this.duration = kDefaultDuration,
    this.animated = true,
    this.onSurface = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconThemeData = IconTheme.of(context);
    final theme = Theme.of(context);
    final compTheme =
        ComponentTheme.maybeOf<CircularProgressIndicatorTheme>(context);

    final effectiveSize = styleValue(
        widgetValue: size,
        themeValue: compTheme?.size,
        defaultValue:
            (iconThemeData.size ?? 24 * theme.scaling) - 8 * theme.scaling);

    final effectiveColor = styleValue(
        widgetValue: color,
        themeValue: compTheme?.color,
        defaultValue: onSurface
            ? theme.colorScheme.background
            : theme.colorScheme.primary);

    final effectiveBackgroundColor = styleValue(
        widgetValue: backgroundColor,
        themeValue: compTheme?.backgroundColor,
        defaultValue: effectiveColor.scaleAlpha(0.2));

    final effectiveStrokeWidth = styleValue(
        widgetValue: strokeWidth,
        themeValue: compTheme?.strokeWidth,
        defaultValue: effectiveSize / 12);

    if (value == null || !animated) {
      return RepaintBoundary(
        child: SizedBox(
          width: effectiveSize,
          height: effectiveSize,
          child: mat.CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
            color: effectiveColor,
            backgroundColor: effectiveBackgroundColor,
            strokeWidth: effectiveStrokeWidth,
            value: value,
          ),
        ),
      );
    } else {
      return AnimatedValueBuilder(
        value: value!,
        duration: duration,
        builder: (context, value, child) {
          return RepaintBoundary(
            child: SizedBox(
              width: effectiveSize,
              height: effectiveSize,
              child: mat.CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
                color: effectiveColor,
                backgroundColor: effectiveBackgroundColor,
                strokeWidth: effectiveStrokeWidth,
                value: value,
              ),
            ),
          );
        },
      );
    }
  }
}
