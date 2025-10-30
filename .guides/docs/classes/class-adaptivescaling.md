---
title: "Class: AdaptiveScaling"
description: "Defines scaling behavior for adaptive layouts."
---

```dart
/// Defines scaling behavior for adaptive layouts.
///
/// Provides different scaling strategies for text and icons.
class AdaptiveScaling {
  /// Default scaling for desktop layouts (1.0).
  static const AdaptiveScaling desktop = AdaptiveScaling();
  /// Default scaling for mobile layouts (1.25x).
  static const AdaptiveScaling mobile = AdaptiveScaling(1.25);
  /// Scaling factor for border radius.
  final double radiusScaling;
  /// Scaling factor for component sizes.
  final double sizeScaling;
  /// Scaling factor for text.
  final double textScaling;
  /// Creates uniform [AdaptiveScaling] with the same factor for all properties.
  ///
  /// Parameters:
  /// - [scaling] (`double`, default: 1): Scaling factor for radius, size, and text.
  const AdaptiveScaling([double scaling = 1]);
  /// Creates [AdaptiveScaling] with individual scaling factors.
  ///
  /// Parameters:
  /// - [radiusScaling] (`double`, default: 1): Border radius scaling factor.
  /// - [sizeScaling] (`double`, default: 1): Size and spacing scaling factor.
  /// - [textScaling] (`double`, default: 1): Text and icon scaling factor.
  const AdaptiveScaling.only({this.radiusScaling = 1, this.sizeScaling = 1, this.textScaling = 1});
  /// Applies this scaling to a theme.
  ///
  /// Returns a new ThemeData with radius, sizing, typography, and icon theme
  /// scaled according to this AdaptiveScaling's factors.
  ///
  /// Parameters:
  /// - [theme] (ThemeData, required): Theme to scale
  ///
  /// Returns scaled ThemeData.
  ThemeData scale(ThemeData theme);
  /// Linearly interpolates between two AdaptiveScaling instances.
  ///
  /// Creates a new AdaptiveScaling that represents a transition between [a] and [b]
  /// at position [t]. When t=0, returns [a]; when t=1, returns [b].
  ///
  /// Parameters:
  /// - [a] (AdaptiveScaling, required): Start scaling
  /// - [b] (AdaptiveScaling, required): End scaling
  /// - [t] (double, required): Interpolation position (0.0 to 1.0)
  ///
  /// Returns interpolated AdaptiveScaling.
  static AdaptiveScaling lerp(AdaptiveScaling a, AdaptiveScaling b, double t);
}
```
