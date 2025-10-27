---
title: "Class: CardTheme"
description: "Theme data for customizing [Card] and [SurfaceCard] widget appearance."
---

```dart
/// Theme data for customizing [Card] and [SurfaceCard] widget appearance.
///
/// This class defines the visual properties that can be applied to card widgets,
/// including padding, fill behavior, colors, borders, shadows, and surface effects.
/// These properties can be set at the theme level to provide consistent styling
/// across the application.
///
/// The theme affects both regular cards and surface cards, with surface cards
/// supporting additional blur and opacity effects for glassmorphism styling.
class CardTheme {
  /// Padding inside the card.
  final EdgeInsetsGeometry? padding;
  /// Whether the card is filled.
  final bool? filled;
  /// The fill color when [filled] is true.
  final Color? fillColor;
  /// Border radius of the card.
  final BorderRadiusGeometry? borderRadius;
  /// Border color of the card.
  final Color? borderColor;
  /// Border width of the card.
  final double? borderWidth;
  /// Clip behavior of the card.
  final Clip? clipBehavior;
  /// Box shadow of the card.
  final List<BoxShadow>? boxShadow;
  /// Surface opacity for blurred background.
  final double? surfaceOpacity;
  /// Surface blur for blurred background.
  final double? surfaceBlur;
  /// Animation duration for transitions.
  final Duration? duration;
  /// Creates a [CardTheme].
  const CardTheme({this.padding, this.filled, this.fillColor, this.borderRadius, this.borderColor, this.borderWidth, this.clipBehavior, this.boxShadow, this.surfaceOpacity, this.surfaceBlur, this.duration});
  /// Creates a copy of this theme with the given values replaced.
  CardTheme copyWith({ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<bool?>? filled, ValueGetter<Color?>? fillColor, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<Color?>? borderColor, ValueGetter<double?>? borderWidth, ValueGetter<Clip?>? clipBehavior, ValueGetter<List<BoxShadow>?>? boxShadow, ValueGetter<double?>? surfaceOpacity, ValueGetter<double?>? surfaceBlur, ValueGetter<Duration?>? duration});
  bool operator ==(Object other);
  int get hashCode;
}
```
