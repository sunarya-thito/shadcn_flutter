---
title: "Class: AnimatedCheckPainter"
description: "Custom painter for drawing animated checkmarks in checkboxes."
---

```dart
/// Custom painter for drawing animated checkmarks in checkboxes.
///
/// Renders a smooth checkmark animation that draws progressively from left to right
/// in two stroke segments. The animation provides visual feedback when transitioning
/// to the checked state, creating a satisfying user experience.
///
/// The checkmark is drawn as two connected line segments: a shorter diagonal line
/// from bottom-left toward center, and a longer diagonal line from center to top-right.
/// The [progress] parameter controls how much of the checkmark is visible.
///
/// Used internally by [Checkbox] - not typically instantiated directly by consumers.
class AnimatedCheckPainter extends CustomPainter {
  /// Animation progress from 0.0 to 1.0 controlling checkmark visibility.
  ///
  /// At 0.0, no checkmark is visible. At 1.0, the complete checkmark is drawn.
  /// Values between 0.0 and 1.0 show partial drawing progress with smooth transitions.
  final double progress;
  /// Color used to draw the checkmark strokes.
  ///
  /// Typically the primary foreground color to provide contrast against
  /// the checkbox's active background color.
  final Color color;
  /// Width of the checkmark stroke lines in logical pixels.
  ///
  /// Controls the thickness of the drawn checkmark. Usually scaled with
  /// the theme's scaling factor for consistent appearance across screen densities.
  final double strokeWidth;
  /// Creates an [AnimatedCheckPainter].
  ///
  /// All parameters are required as they directly control the checkmark appearance
  /// and animation state. The painter should be recreated when any parameter changes.
  ///
  /// Parameters:
  /// - [progress] (double, required): animation progress 0.0-1.0
  /// - [color] (Color, required): checkmark stroke color
  /// - [strokeWidth] (double, required): stroke thickness in logical pixels
  ///
  /// Example usage within CustomPaint:
  /// ```dart
  /// CustomPaint(
  ///   painter: AnimatedCheckPainter(
  ///     progress: animationValue,
  ///     color: theme.primaryForeground,
  ///     strokeWidth: 2.0,
  ///   ),
  /// )
  /// ```
  AnimatedCheckPainter({required this.progress, required this.color, required this.strokeWidth});
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant AnimatedCheckPainter oldDelegate);
}
```
