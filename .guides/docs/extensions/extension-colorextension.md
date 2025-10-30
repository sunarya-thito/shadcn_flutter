---
title: "Extension: ColorExtension"
description: "Extension adding color manipulation utilities to [Color]."
---

```dart
/// Extension adding color manipulation utilities to [Color].
extension ColorExtension on Color {
  /// Scales the alpha channel by a factor.
  ///
  /// Parameters:
  /// - [factor] (`double`, required): Multiplier for alpha (0.0 to 1.0+).
  ///
  /// Returns: `Color` — color with scaled alpha.
  Color scaleAlpha(double factor);
  /// Gets a contrasting color based on luminance.
  ///
  /// Adjusts luminance to create contrast. If current lightness >= 0.5,
  /// reduces it; otherwise increases it.
  ///
  /// Parameters:
  /// - [luminanceContrast] (`double`, default: 1): Contrast factor (0.0 to 1.0).
  ///
  /// Returns: `Color` — contrasting color.
  Color getContrastColor([double luminanceContrast = 1]);
  /// Sets the luminance (lightness) of this color.
  ///
  /// Parameters:
  /// - [luminance] (`double`, required): Target luminance (0.0 to 1.0).
  ///
  /// Returns: `Color` — color with specified luminance.
  Color withLuminance(double luminance);
  /// Converts this color to hexadecimal string.
  ///
  /// Parameters:
  /// - [includeHashSign] (`bool`, default: false): Whether to prefix with '#'.
  /// - [includeAlpha] (`bool`, default: true): Whether to include alpha channel.
  ///
  /// Returns: `String` — hexadecimal color representation.
  ///
  /// Example:
  /// ```dart
  /// Color.fromARGB(255, 255, 0, 0).toHex() // 'ffff0000'
  /// Color.fromARGB(255, 255, 0, 0).toHex(includeHashSign: true) // '#ffff0000'
  /// Color.fromARGB(255, 255, 0, 0).toHex(includeAlpha: false) // 'ff0000'
  /// ```
  String toHex({bool includeHashSign = false, bool includeAlpha = true});
  /// Converts this color to HSL color space.
  ///
  /// Returns: `HSLColor` — HSL representation.
  HSLColor toHSL();
  /// Converts this color to HSV color space.
  ///
  /// Returns: `HSVColor` — HSV representation.
  HSVColor toHSV();
}
```
