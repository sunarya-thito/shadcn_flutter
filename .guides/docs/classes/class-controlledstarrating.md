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
  final double step;
  final Axis direction;
  final double max;
  final Color? activeColor;
  final Color? backgroundColor;
  final double starPoints;
  final double? starSize;
  final double? starSpacing;
  final double? starPointRounding;
  final double? starValleyRounding;
  final double? starSquash;
  final double? starInnerRadiusRatio;
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
