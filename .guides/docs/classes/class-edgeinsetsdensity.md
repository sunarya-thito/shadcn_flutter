---
title: "Class: EdgeInsetsDensity"
description: "Fixed direction density edge insets using left/right.   Use this when direction is fixed (not RTL-aware). Values are multipliers  that will be multiplied by the base padding from [Density].   Example:  ```dart  // Creates fixed padding that adapts to density  const EdgeInsetsDensity.symmetric(    horizontal: padLg,  // 1.0 * basePadding on left and right    vertical: padSm,    // 0.5 * basePadding on top and bottom  )  ```"
---

```dart
/// Fixed direction density edge insets using left/right.
///
/// Use this when direction is fixed (not RTL-aware). Values are multipliers
/// that will be multiplied by the base padding from [Density].
///
/// Example:
/// ```dart
/// // Creates fixed padding that adapts to density
/// const EdgeInsetsDensity.symmetric(
///   horizontal: padLg,  // 1.0 * basePadding on left and right
///   vertical: padSm,    // 0.5 * basePadding on top and bottom
/// )
/// ```
class EdgeInsetsDensity extends EdgeInsets implements DensityEdgeInsetsGeometry {
  /// Creates density insets with individual values.
  const EdgeInsetsDensity.only({super.left = 0.0, super.top = 0.0, super.right = 0.0, super.bottom = 0.0});
  /// Creates density insets with the same value on all sides.
  const EdgeInsetsDensity.all(super.value);
  /// Creates density insets with symmetric values.
  const EdgeInsetsDensity.symmetric({super.vertical = 0.0, super.horizontal = 0.0});
  EdgeInsets resolveDensity(double basePadding);
  EdgeInsetsDensity copyWith({double? left, double? top, double? right, double? bottom});
}
```
