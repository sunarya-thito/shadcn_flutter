---
title: "Class: CircularProgressIndicator"
description: "A circular progress indicator that displays task completion as a rotating arc."
---

```dart
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
  const CircularProgressIndicator({super.key, this.value, this.size, this.color, this.backgroundColor, this.strokeWidth, this.duration = kDefaultDuration, this.animated = true, this.onSurface = false});
  Widget build(BuildContext context);
}
```
