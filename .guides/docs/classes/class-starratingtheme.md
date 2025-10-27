---
title: "Class: StarRatingTheme"
description: "Theme data for customizing [StarRating] widget appearance."
---

```dart
/// Theme data for customizing [StarRating] widget appearance.
///
/// This class defines the visual properties that can be applied to
/// [StarRating] widgets, including colors for filled and unfilled stars,
/// star sizing, and spacing between stars. These properties can be set
/// at the theme level to provide consistent styling across the application.
class StarRatingTheme {
  /// The color of the filled portion of the stars.
  final Color? activeColor;
  /// The color of the unfilled portion of the stars.
  final Color? backgroundColor;
  /// The size of each star.
  final double? starSize;
  /// The spacing between stars.
  final double? starSpacing;
  /// Creates a [StarRatingTheme].
  const StarRatingTheme({this.activeColor, this.backgroundColor, this.starSize, this.starSpacing});
  /// Returns a copy of this theme with the given fields replaced.
  StarRatingTheme copyWith({ValueGetter<Color?>? activeColor, ValueGetter<Color?>? backgroundColor, ValueGetter<double?>? starSize, ValueGetter<double?>? starSpacing});
  bool operator ==(Object other);
  int get hashCode;
}
```
