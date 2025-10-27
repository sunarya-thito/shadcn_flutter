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
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool? filled;
  final Color? fillColor;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final Clip? clipBehavior;
  final List<BoxShadow>? boxShadow;
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final Duration? duration;
  const Card({super.key, required this.child, this.padding, this.filled, this.fillColor, this.borderRadius, this.clipBehavior, this.borderColor, this.borderWidth, this.boxShadow, this.surfaceOpacity, this.surfaceBlur, this.duration});
  Widget build(BuildContext context);
}
```
