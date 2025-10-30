---
title: "Enum: HSLColorSliderType"
description: "Defines available slider types for HSL color pickers."
---

```dart
/// Defines available slider types for HSL color pickers.
///
/// Each slider type controls different aspects of the HSL color model,
/// allowing fine-tuned control over hue, saturation, luminance, and alpha channels.
enum HSLColorSliderType {
  /// Hue slider only.
  hue,
  /// Combined hue and saturation slider.
  hueSat,
  /// Combined hue and luminance slider.
  hueLum,
  /// Combined hue and alpha slider.
  hueAlpha,
  /// Saturation slider only.
  sat,
  /// Combined saturation and luminance slider.
  satLum,
  /// Combined saturation and alpha slider.
  satAlpha,
  /// Luminance (lightness) slider only.
  lum,
  /// Combined luminance and alpha slider.
  lumAlpha,
  /// Alpha (opacity) slider only.
  alpha,
}
```
