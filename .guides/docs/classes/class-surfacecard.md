---
title: "Class: SurfaceCard"
description: "A card variant with surface blur and opacity effects."
---

```dart
/// A card variant with surface blur and opacity effects.
///
/// Similar to [Card] but with enhanced visual effects including frosted glass
/// or translucent surface appearances. Useful for overlays or layered UI designs.
///
/// Example:
/// ```dart
/// SurfaceCard(
///   surfaceBlur: 10,
///   surfaceOpacity: 0.8,
///   child: Text('Overlay content'),
/// )
/// ```
class SurfaceCard extends StatelessWidget {
  /// The child widget to display within the card.
  final Widget child;
  /// Padding inside the card around the [child].
  ///
  /// If `null`, uses default padding from the theme.
  final EdgeInsetsGeometry? padding;
  /// Whether the card has a filled background.
  ///
  /// When `true`, applies a solid background color.
  final bool? filled;
  /// The background fill color of the card.
  ///
  /// Only applies when [filled] is `true`. If `null`, uses theme default.
  final Color? fillColor;
  /// Border radius for rounded corners on the card.
  ///
  /// If `null`, uses default border radius from the theme.
  final BorderRadiusGeometry? borderRadius;
  /// Color of the card's border.
  ///
  /// If `null`, uses default border color from the theme.
  final Color? borderColor;
  /// Width of the card's border in logical pixels.
  ///
  /// If `null`, uses default border width from the theme.
  final double? borderWidth;
  /// How to clip the card's content.
  ///
  /// Controls overflow clipping behavior. If `null`, uses [Clip.none].
  final Clip? clipBehavior;
  /// Box shadows to apply to the card.
  ///
  /// Creates elevation and depth effects. If `null`, no shadows are applied.
  final List<BoxShadow>? boxShadow;
  /// Opacity of the card's surface effect.
  ///
  /// Controls transparency for frosted glass or translucent effects. Higher
  /// values are more opaque.
  final double? surfaceOpacity;
  /// Blur amount for the card's surface effect.
  ///
  /// Creates a frosted glass appearance. Higher values create more blur.
  final double? surfaceBlur;
  /// Duration for card appearance animations.
  ///
  /// Controls how long transitions take when properties change.
  final Duration? duration;
  /// Creates a [SurfaceCard].
  const SurfaceCard({super.key, required this.child, this.padding, this.filled, this.fillColor, this.borderRadius, this.clipBehavior, this.borderColor, this.borderWidth, this.boxShadow, this.surfaceOpacity, this.surfaceBlur, this.duration});
  Widget build(BuildContext context);
}
```
