---
title: "Class: ControlledStarRating"
description: "Reactive star rating widget with automatic state management and controller support."
---

```dart
/// Reactive star rating widget with automatic state management and controller support.
///
/// A high-level star rating widget that provides automatic state management through
/// the controlled component pattern. Supports both controller-based and callback-based
/// state management with comprehensive customization options for star appearance,
/// interaction behavior, and rating precision.
///
/// ## Features
///
/// - **Fractional ratings**: Support for decimal values (e.g., 3.5 stars)
/// - **Step control**: Configurable rating increments for precision
/// - **Visual customization**: Comprehensive star shape and appearance options
/// - **Interactive feedback**: Touch and drag support for rating selection
/// - **Form integration**: Automatic validation and form field registration
/// - **Accessibility**: Full screen reader and keyboard navigation support
///
/// ## Usage Patterns
///
/// **Controller-based (recommended for complex state):**
/// ```dart
/// final controller = StarRatingController(3.5);
///
/// ControlledStarRating(
///   controller: controller,
///   max: 5.0,
///   step: 0.5,
///   activeColor: Colors.amber,
/// )
/// ```
///
/// **Callback-based (simple state management):**
/// ```dart
/// double currentRating = 0.0;
///
/// ControlledStarRating(
///   initialValue: currentRating,
///   onChanged: (rating) => setState(() => currentRating = rating),
///   max: 5.0,
///   step: 1.0,
/// )
/// ```
class ControlledStarRating extends StatelessWidget with ControlledComponent<double> {
  final double initialValue;
  final ValueChanged<double>? onChanged;
  final bool enabled;
  final StarRatingController? controller;
  /// The minimum increment for rating changes.
  ///
  /// When a user interacts with the star rating, the value will snap to
  /// multiples of this step. For example, a step of `0.5` allows half-star
  /// ratings, while `1.0` allows only whole-star ratings.
  final double step;
  /// The layout direction of the stars.
  ///
  /// Stars can be arranged horizontally ([Axis.horizontal]) or vertically
  /// ([Axis.vertical]). Defaults to horizontal.
  final Axis direction;
  /// The maximum rating value.
  ///
  /// Determines how many stars are displayed. For example, `max: 5.0` shows
  /// 5 stars. Defaults to `5.0`.
  final double max;
  /// The color of filled star portions.
  ///
  /// If `null`, uses the theme's primary color.
  final Color? activeColor;
  /// The color of unfilled star portions.
  ///
  /// If `null`, uses a default background color from the theme.
  final Color? backgroundColor;
  /// The number of points per star.
  ///
  /// Controls the star shape. Defaults to `5` for traditional five-pointed
  /// stars. Higher values create stars with more points.
  final double starPoints;
  /// Override size of each star.
  ///
  /// If `null`, uses the default size from the theme.
  final double? starSize;
  /// Override spacing between stars.
  ///
  /// If `null`, uses the default spacing from the theme.
  final double? starSpacing;
  /// Rounding radius for star points.
  ///
  /// Controls how rounded the tips of the star points appear. If `null`,
  /// uses sharp points.
  final double? starPointRounding;
  /// Rounding radius for star valleys.
  ///
  /// Controls how rounded the inner valleys between star points appear.
  /// If `null`, uses sharp valleys.
  final double? starValleyRounding;
  /// Vertical compression factor for stars.
  ///
  /// Values less than `1.0` make stars appear squashed. If `null`, stars
  /// maintain their natural proportions.
  final double? starSquash;
  /// Inner to outer radius ratio for stars.
  ///
  /// Controls the depth of star valleys. Lower values create deeper valleys.
  /// If `null`, uses a default ratio.
  final double? starInnerRadiusRatio;
  /// Rotation angle for stars in radians.
  ///
  /// Rotates each star by this angle. If `null`, stars are not rotated.
  final double? starRotation;
  /// Creates a [ControlledStarRating].
  ///
  /// Either [controller] or [onChanged] should be provided for interactivity.
  /// The widget supports both controller-based and callback-based state management
  /// patterns with extensive star appearance customization options.
  ///
  /// Parameters:
  /// - [controller] (StarRatingController?, optional): external state controller
  /// - [initialValue] (double, default: 0.0): starting rating when no controller
  /// - [onChanged] (`ValueChanged<double>?`, optional): rating change callback
  /// - [enabled] (bool, default: true): whether star rating is interactive
  /// - [step] (double, default: 0.5): minimum increment for rating changes
  /// - [direction] (Axis, default: horizontal): layout direction of stars
  /// - [max] (double, default: 5.0): maximum rating value
  /// - [activeColor] (Color?, optional): color of filled star portions
  /// - [backgroundColor] (Color?, optional): color of unfilled star portions
  /// - [starPoints] (double, default: 5): number of points per star
  /// - [starSize] (double?, optional): override size of each star
  /// - [starSpacing] (double?, optional): override spacing between stars
  /// - [starPointRounding] (double?, optional): rounding radius for star points
  /// - [starValleyRounding] (double?, optional): rounding radius for star valleys
  /// - [starSquash] (double?, optional): vertical compression factor
  /// - [starInnerRadiusRatio] (double?, optional): inner to outer radius ratio
  /// - [starRotation] (double?, optional): rotation angle in radians
  ///
  /// Example:
  /// ```dart
  /// ControlledStarRating(
  ///   controller: controller,
  ///   max: 5.0,
  ///   step: 0.1,
  ///   activeColor: Colors.amber,
  ///   backgroundColor: Colors.grey[300],
  /// )
  /// ```
  const ControlledStarRating({super.key, this.controller, this.initialValue = 0.0, this.onChanged, this.enabled = true, this.step = 0.5, this.direction = Axis.horizontal, this.max = 5.0, this.activeColor, this.backgroundColor, this.starPoints = 5, this.starSize, this.starSpacing, this.starPointRounding, this.starValleyRounding, this.starSquash, this.starInnerRadiusRatio, this.starRotation});
  Widget build(BuildContext context);
}
```
