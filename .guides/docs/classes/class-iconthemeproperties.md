---
title: "Class: IconThemeProperties"
description: "Properties for icon theming."
---

```dart
/// Properties for icon theming.
///
/// Defines size and color for different icon sizes across the theme.
class IconThemeProperties {
  /// Icon theme for 4x-small icons (6px).
  final IconThemeData x4Small;
  /// Icon theme for 3x-small icons (8px).
  final IconThemeData x3Small;
  /// Icon theme for 2x-small icons (10px).
  final IconThemeData x2Small;
  /// Icon theme for extra-small icons (12px).
  final IconThemeData xSmall;
  /// Icon theme for small icons (16px).
  final IconThemeData small;
  /// Icon theme for medium icons (20px).
  final IconThemeData medium;
  /// Icon theme for large icons (24px).
  final IconThemeData large;
  /// Icon theme for extra-large icons (32px).
  final IconThemeData xLarge;
  /// Icon theme for 2x-large icons (40px).
  final IconThemeData x2Large;
  /// Icon theme for 3x-large icons (48px).
  final IconThemeData x3Large;
  /// Icon theme for 4x-large icons (56px).
  final IconThemeData x4Large;
  /// Creates [IconThemeProperties] with default icon sizes.
  ///
  /// All parameters are optional and default to predefined sizes.
  const IconThemeProperties({this.x4Small = const IconThemeData(size: 6), this.x3Small = const IconThemeData(size: 8), this.x2Small = const IconThemeData(size: 10), this.xSmall = const IconThemeData(size: 12), this.small = const IconThemeData(size: 16), this.medium = const IconThemeData(size: 20), this.large = const IconThemeData(size: 24), this.xLarge = const IconThemeData(size: 32), this.x2Large = const IconThemeData(size: 40), this.x3Large = const IconThemeData(size: 48), this.x4Large = const IconThemeData(size: 56)});
  /// Creates a copy with updated icon themes.
  ///
  /// All parameters are optional getters. Omitted values retain their current value.
  ///
  /// Returns: `IconThemeProperties` — a new instance with updated values.
  IconThemeProperties copyWith({ValueGetter<IconThemeData>? x4Small, ValueGetter<IconThemeData>? x3Small, ValueGetter<IconThemeData>? x2Small, ValueGetter<IconThemeData>? xSmall, ValueGetter<IconThemeData>? small, ValueGetter<IconThemeData>? medium, ValueGetter<IconThemeData>? large, ValueGetter<IconThemeData>? xLarge, ValueGetter<IconThemeData>? x2Large, ValueGetter<IconThemeData>? x3Large, ValueGetter<IconThemeData>? x4Large});
  /// Scales all icon sizes by the given factor.
  ///
  /// Parameters:
  /// - [factor] (`double`, required): Scaling factor to apply.
  ///
  /// Returns: `IconThemeProperties` — scaled icon theme properties.
  IconThemeProperties scale(double factor);
  /// Linearly interpolates between two icon theme properties.
  ///
  /// Parameters:
  /// - [a] (`IconThemeProperties`, required): Start properties.
  /// - [b] (`IconThemeProperties`, required): End properties.
  /// - [t] (`double`, required): Interpolation position (0.0 to 1.0).
  ///
  /// Returns: `IconThemeProperties` — interpolated properties.
  static IconThemeProperties lerp(IconThemeProperties a, IconThemeProperties b, double t);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
