---
title: "Class: StarRating"
description: "An interactive star rating widget for collecting user feedback and ratings."
---

```dart
/// An interactive star rating widget for collecting user feedback and ratings.
///
/// [StarRating] provides a customizable rating interface using star-shaped
/// indicators that users can tap or drag to select a rating value. The widget
/// supports fractional ratings, customizable star appearance, and both horizontal
/// and vertical orientations.
///
/// Key features:
/// - Interactive star-based rating selection
/// - Support for fractional ratings (e.g., 3.5 stars)
/// - Customizable star shape with points, rounding, and squashing
/// - Horizontal and vertical layout orientations
/// - Configurable step increments for rating precision
/// - Visual feedback with filled/unfilled star indicators
/// - Touch and drag interaction support
/// - Accessibility integration
///
/// The widget displays a series of star shapes that fill based on the current
/// rating value. Users can interact with the stars to select new rating values,
/// with support for fine-grained control through the step parameter.
///
/// Star appearance can be extensively customized:
/// - Number of points per star
/// - Star size and spacing
/// - Point and valley rounding
/// - Star squashing and inner radius ratio
/// - Rotation angle
/// - Fill and background colors
///
/// Example:
/// ```dart
/// StarRating(
///   value: currentRating,
///   max: 5.0,
///   step: 0.5, // Allow half-star ratings
///   onChanged: (rating) => setState(() => currentRating = rating),
///   activeColor: Colors.amber,
///   backgroundColor: Colors.grey[300],
/// );
/// ```
class StarRating extends StatefulWidget {
  /// The current rating value.
  ///
  /// Should be between `0` and [max]. Fractional values are supported.
  final double value;
  /// Callback invoked when the rating changes.
  ///
  /// If `null`, the widget is in read-only mode.
  final ValueChanged<double>? onChanged;
  /// The minimum increment for rating changes.
  ///
  /// When a user interacts with the stars, the value will snap to multiples
  /// of this step. Defaults to `0.5` for half-star precision.
  final double step;
  /// The layout direction of the stars.
  ///
  /// Can be [Axis.horizontal] or [Axis.vertical]. Defaults to horizontal.
  final Axis direction;
  /// The maximum rating value.
  ///
  /// Determines how many stars are displayed. Defaults to `5.0`.
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
  /// Defaults to `5` for traditional five-pointed stars.
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
  /// Whether the star rating is interactive.
  ///
  /// When `false`, the widget is in read-only mode. Defaults to `true` if
  /// [onChanged] is provided.
  final bool? enabled;
  /// Creates a [StarRating].
  const StarRating({super.key, required this.value, this.onChanged, this.step = 0.5, this.direction = Axis.horizontal, this.max = 5.0, this.activeColor, this.backgroundColor, this.starPoints = 5, this.starSize, this.starSpacing, this.starPointRounding, this.starValleyRounding, this.starSquash, this.starInnerRadiusRatio, this.starRotation, this.enabled});
  State<StarRating> createState();
}
```
