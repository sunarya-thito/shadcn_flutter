---
title: "Class: ButtonDensity"
description: "Defines the padding density for button components."
---

```dart
/// Defines the padding density for button components.
///
/// [ButtonDensity] controls how much internal padding buttons have, affecting
/// their overall size and touch target area. Different density levels are
/// appropriate for different use cases and layout constraints.
///
/// Example:
/// ```dart
/// Button.primary(
///   style: ButtonStyle.primary().copyWith(density: ButtonDensity.compact),
///   child: Text('Compact Button'),
/// );
/// ```
class ButtonDensity {
  /// Function that modifies base padding to achieve the desired density.
  final DensityModifier modifier;
  /// Creates a [ButtonDensity] with the specified padding modifier.
  const ButtonDensity(this.modifier);
  /// Standard padding density (no modification).
  static const ButtonDensity normal = ButtonDensity(_densityNormal);
  /// Increased padding for more comfortable touch targets.
  static const ButtonDensity comfortable = ButtonDensity(_densityComfortable);
  /// Square padding suitable for icon-only buttons.
  static const ButtonDensity icon = ButtonDensity(_densityIcon);
  /// Comfortable square padding for icon-only buttons.
  static const ButtonDensity iconComfortable = ButtonDensity(_densityIconComfortable);
  /// Dense square padding for compact icon buttons.
  static const ButtonDensity iconDense = ButtonDensity(_densityIconDense);
  /// Reduced padding for tighter layouts (50% of normal).
  static const ButtonDensity dense = ButtonDensity(_densityDense);
  /// Minimal padding for very compact layouts (zero padding).
  static const ButtonDensity compact = ButtonDensity(_densityCompact);
}
```
