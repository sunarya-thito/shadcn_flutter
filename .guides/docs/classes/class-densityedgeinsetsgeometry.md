---
title: "Class: DensityEdgeInsetsGeometry"
description: "Interface for edge insets that can be resolved using density settings."
---

```dart
/// Interface for edge insets that can be resolved using density settings.
///
/// Implement this interface to create custom density-aware edge insets.
/// Use [DirectionalEdgeInsetsDensity] for RTL-aware insets or
/// [EdgeInsetsDensity] for fixed left/right insets.
abstract class DensityEdgeInsetsGeometry extends EdgeInsetsGeometry {
  /// Resolves the density multipliers to actual pixel values.
  ///
  /// Parameters:
  /// - [basePadding] (`double`, required): The base padding from [Density].
  EdgeInsetsGeometry resolveDensity(double basePadding);
}
```
