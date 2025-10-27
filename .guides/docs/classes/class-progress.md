---
title: "Class: Progress"
description: "A linear progress indicator that visually represents task completion."
---

```dart
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
  double? get normalizedValue;
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
  const Progress({super.key, this.progress, this.min = 0.0, this.max = 1.0, this.disableAnimation = false, this.color, this.backgroundColor});
  Widget build(BuildContext context);
}
```
