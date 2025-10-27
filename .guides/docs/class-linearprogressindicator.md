---
title: "Class: LinearProgressIndicator"
description: "A sophisticated linear progress indicator with advanced visual effects."
---

```dart
/// A sophisticated linear progress indicator with advanced visual effects.
///
/// The LinearProgressIndicator provides both determinate and indeterminate progress
/// visualization with enhanced features including optional spark effects, smooth
/// animations, and comprehensive theming support. Built with custom painting for
/// precise control over visual presentation and performance.
///
/// For determinate progress, displays completion as a horizontal bar that fills
/// from left to right. For indeterminate progress (when value is null), shows
/// a continuous animation with two overlapping progress segments that move across
/// the track in a coordinated pattern.
///
/// Key features:
/// - Determinate and indeterminate progress modes
/// - Optional spark effects with radial gradient animation
/// - Smooth animated transitions with disable option
/// - RTL (right-to-left) text direction support
/// - Custom painting for optimal rendering performance
/// - Comprehensive theming via [LinearProgressIndicatorTheme]
/// - Responsive sizing with theme scaling integration
///
/// The indeterminate animation uses precisely timed curves to create a natural,
/// material design compliant motion pattern that communicates ongoing activity
/// without specific completion timing.
///
/// Example:
/// ```dart
/// LinearProgressIndicator(
///   value: 0.7,
///   showSparks: true,
///   color: Colors.blue,
///   minHeight: 6.0,
/// );
/// ```
class LinearProgressIndicator extends StatelessWidget {
  /// The progress completion value between 0.0 and 1.0.
  ///
  /// Type: `double?`. If null, displays indeterminate animation with dual
  /// moving progress segments. When provided, shows determinate progress.
  final double? value;
  /// The background color of the progress track.
  ///
  /// Type: `Color?`. If null, uses theme background color or semi-transparent
  /// version of progress color. Overrides theme configuration.
  final Color? backgroundColor;
  /// The minimum height of the progress indicator.
  ///
  /// Type: `double?`. If null, uses theme minimum height or 2.0 scaled
  /// by theme scaling factor. Overrides theme configuration.
  final double? minHeight;
  /// The primary color of the progress fill.
  ///
  /// Type: `Color?`. If null, uses theme primary color. Applied to both
  /// progress segments in indeterminate mode. Overrides theme configuration.
  final Color? color;
  /// The border radius of the progress container.
  ///
  /// Type: `BorderRadiusGeometry?`. If null, uses BorderRadius.zero.
  /// Applied via [ClipRRect] to both track and progress elements.
  final BorderRadiusGeometry? borderRadius;
  /// Whether to display spark effects at the progress head.
  ///
  /// Type: `bool?`. If null, defaults to false. Shows radial gradient
  /// spark effect at the leading edge for enhanced visual feedback.
  final bool? showSparks;
  /// Whether to disable smooth progress animations.
  ///
  /// Type: `bool?`. If null, defaults to false. When true, disables
  /// [AnimatedValueBuilder] for instant progress changes.
  final bool? disableAnimation;
  /// Creates a [LinearProgressIndicator].
  ///
  /// The component automatically handles both determinate and indeterminate modes
  /// based on whether [value] is provided. Theming and visual effects can be
  /// customized through individual parameters or via [LinearProgressIndicatorTheme].
  ///
  /// Parameters:
  /// - [value] (double?, optional): Progress completion (0.0-1.0) or null for indeterminate
  /// - [backgroundColor] (Color?, optional): Track background color override
  /// - [minHeight] (double?, optional): Minimum indicator height override
  /// - [color] (Color?, optional): Progress fill color override
  /// - [borderRadius] (BorderRadiusGeometry?, optional): Container border radius override
  /// - [showSparks] (bool?, optional): Whether to show spark effects
  /// - [disableAnimation] (bool?, optional): Whether to disable smooth transitions
  ///
  /// Example:
  /// ```dart
  /// LinearProgressIndicator(
  ///   value: 0.4,
  ///   color: Colors.green,
  ///   backgroundColor: Colors.grey.shade300,
  ///   minHeight: 8.0,
  ///   showSparks: true,
  /// );
  /// ```
  const LinearProgressIndicator({super.key, this.value, this.backgroundColor, this.minHeight, this.color, this.borderRadius, this.showSparks, this.disableAnimation});
  Widget build(BuildContext context);
}
```
