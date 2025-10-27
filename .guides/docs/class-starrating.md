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
  final double value;
  final ValueChanged<double>? onChanged;
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
  final bool? enabled;
  const StarRating({super.key, required this.value, this.onChanged, this.step = 0.5, this.direction = Axis.horizontal, this.max = 5.0, this.activeColor, this.backgroundColor, this.starPoints = 5, this.starSize, this.starSpacing, this.starPointRounding, this.starValleyRounding, this.starSquash, this.starInnerRadiusRatio, this.starRotation, this.enabled});
  State<StarRating> createState();
}
```
