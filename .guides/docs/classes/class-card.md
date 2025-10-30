---
title: "Class: Card"
description: "A versatile container widget that provides a card-like appearance with comprehensive styling options."
---

```dart
/// A versatile container widget that provides a card-like appearance with comprehensive styling options.
///
/// [Card] is a foundational layout component that wraps content in a visually distinct
/// container with configurable borders, shadows, fills, and surface effects. It serves
/// as the basis for many UI patterns including content cards, panels, sections, and
/// grouped information displays.
///
/// Key features:
/// - Flexible fill and border styling options
/// - Configurable shadow effects for depth perception
/// - Customizable corner radius and clipping behavior
/// - Surface effects for glassmorphism and blur styling
/// - Responsive padding with theme integration
/// - Animation support for state transitions
/// - Consistent theming across the application
///
/// The card supports various visual modes:
/// - Filled cards with solid background colors
/// - Outlined cards with transparent backgrounds and borders
/// - Surface cards with blur effects and opacity
/// - Elevated cards with shadow effects
/// - Custom combinations of fill, border, and shadow
///
/// Visual hierarchy can be achieved through:
/// - Shadow depth for elevation indication
/// - Fill colors for emphasis and categorization
/// - Border styles for subtle grouping
/// - Surface effects for modern glass-like appearances
///
/// Example:
/// ```dart
/// Card(
///   filled: true,
///   fillColor: Colors.white,
///   borderRadius: BorderRadius.circular(12),
///   boxShadow: [
///     BoxShadow(
///       color: Colors.black.withOpacity(0.1),
///       blurRadius: 8,
///       offset: Offset(0, 2),
///     ),
///   ],
///   child: Padding(
///     padding: EdgeInsets.all(16),
///     child: Column(
///       children: [
///         Text('Card Title', style: TextStyle(fontWeight: FontWeight.bold)),
///         SizedBox(height: 8),
///         Text('Card content goes here...'),
///       ],
///     ),
///   ),
/// );
/// ```
class Card extends StatelessWidget {
  /// The child widget to display within the card.
  final Widget child;
  /// Padding inside the card around the [child].
  ///
  /// If `null`, uses default padding from the theme.
  final EdgeInsetsGeometry? padding;
  /// Whether the card has a filled background.
  ///
  /// When `true`, the card has a solid background color. When `false` or
  /// `null`, uses theme defaults.
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
  /// Controls the transparency of surface overlays. If `null`, uses theme default.
  final double? surfaceOpacity;
  /// Blur amount for the card's surface effect.
  ///
  /// Creates a frosted glass or blur effect. If `null`, no blur is applied.
  final double? surfaceBlur;
  /// Duration for card appearance animations.
  ///
  /// Controls how long transitions take when card properties change. If `null`,
  /// uses default animation duration.
  final Duration? duration;
  /// Creates a [Card].
  const Card({super.key, required this.child, this.padding, this.filled, this.fillColor, this.borderRadius, this.clipBehavior, this.borderColor, this.borderWidth, this.boxShadow, this.surfaceOpacity, this.surfaceBlur, this.duration});
  Widget build(BuildContext context);
}
```
