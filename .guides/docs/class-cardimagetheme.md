---
title: "Class: CardImageTheme"
description: "Theme configuration for [CardImage] components."
---

```dart
/// Theme configuration for [CardImage] components.
///
/// Defines visual properties like scale animations, background colors,
/// border styling, and layout direction. Applied through the widget tree
/// using [ComponentTheme] to provide consistent theming across card images.
///
/// Example:
/// ```dart
/// ComponentTheme(
///   data: CardImageTheme(
///     hoverScale: 1.1,
///     backgroundColor: Colors.grey.shade100,
///     direction: Axis.horizontal,
///   ),
///   child: MyApp(),
/// );
/// ```
class CardImageTheme {
  /// Button style for the card.
  final AbstractButtonStyle? style;
  /// Layout direction for title/subtitle relative to the image.
  final Axis? direction;
  /// Scale factor when hovering over the image.
  final double? hoverScale;
  /// Normal scale factor for the image.
  final double? normalScale;
  /// Background color for the image container.
  final Color? backgroundColor;
  /// Border color for the image container.
  final Color? borderColor;
  /// Gap between image and text content.
  final double? gap;
  /// Creates a [CardImageTheme].
  ///
  /// All parameters are optional and provide default styling for [CardImage]
  /// widgets in the component tree.
  ///
  /// Parameters:
  /// - [style] (AbstractButtonStyle?): button style configuration
  /// - [direction] (Axis?): layout direction (vertical/horizontal)
  /// - [hoverScale] (double?): image scale on hover (default: 1.05)
  /// - [normalScale] (double?): normal image scale (default: 1.0)
  /// - [backgroundColor] (Color?): image background color
  /// - [borderColor] (Color?): image border color
  /// - [gap] (double?): spacing between image and content
  ///
  /// Example:
  /// ```dart
  /// CardImageTheme(
  ///   hoverScale: 1.1,
  ///   direction: Axis.horizontal,
  ///   backgroundColor: Colors.grey.shade50,
  /// );
  /// ```
  const CardImageTheme({this.style, this.direction, this.hoverScale, this.normalScale, this.backgroundColor, this.borderColor, this.gap});
  /// Creates a copy of this theme with optionally overridden properties.
  ///
  /// Uses [ValueGetter] functions to allow nullable overrides.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = existingTheme.copyWith(
  ///   hoverScale: () => 1.2,
  ///   backgroundColor: () => Colors.blue.shade50,
  /// );
  /// ```
  CardImageTheme copyWith({ValueGetter<AbstractButtonStyle?>? style, ValueGetter<Axis?>? direction, ValueGetter<double?>? hoverScale, ValueGetter<double?>? normalScale, ValueGetter<Color?>? backgroundColor, ValueGetter<Color?>? borderColor, ValueGetter<double?>? gap});
  bool operator ==(Object other);
  int get hashCode;
}
```
