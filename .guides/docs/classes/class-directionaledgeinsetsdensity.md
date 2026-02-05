---
title: "Class: DirectionalEdgeInsetsDensity"
description: "Direction-aware density edge insets using start/end instead of left/right."
---

```dart
/// Direction-aware density edge insets using start/end instead of left/right.
///
/// Use this for RTL-aware layouts. The [start] and [end] values are
/// multipliers that will be multiplied by the base padding from [Density].
///
/// Example:
/// ```dart
/// // Creates padding that adapts to density and text direction
/// const DirectionalEdgeInsetsDensity.symmetric(
///   horizontal: padLg,  // 1.0 * basePadding on start and end
///   vertical: padSm,    // 0.5 * basePadding on top and bottom
/// )
/// ```
class DirectionalEdgeInsetsDensity extends EdgeInsetsDirectional implements DensityEdgeInsetsGeometry {
  /// Creates directional density insets with individual values.
  ///
  /// All values default to 0.0 (no padding).
  const DirectionalEdgeInsetsDensity.only({super.start = 0.0, super.top = 0.0, super.end = 0.0, super.bottom = 0.0});
  /// Creates directional density insets with the same value on all sides.
  const DirectionalEdgeInsetsDensity.all(double value);
  /// Creates directional density insets with symmetric values.
  const DirectionalEdgeInsetsDensity.symmetric({super.vertical = 0.0, super.horizontal = 0.0});
  EdgeInsetsDirectional resolveDensity(double basePadding);
  DirectionalEdgeInsetsDensity copyWith({double? start, double? top, double? end, double? bottom});
}
```
