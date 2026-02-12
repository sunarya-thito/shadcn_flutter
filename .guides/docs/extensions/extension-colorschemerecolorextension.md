---
title: "Extension: ColorSchemeRecolorExtension"
description: "Helpers for deriving accent variants from a base [ColorScheme]."
---

```dart
/// Helpers for deriving accent variants from a base [ColorScheme].
extension ColorSchemeRecolorExtension on ColorScheme {
  /// Returns a copy of this scheme using [primary] as the accent color.
  ColorScheme recolor(Color primary);
  /// Returns a slate-accented scheme.
  ColorScheme get slate;
  /// Returns a gray-accented scheme.
  ColorScheme get gray;
  /// Returns a zinc-accented scheme.
  ColorScheme get zinc;
  /// Returns a neutral-accented scheme.
  ColorScheme get neutral;
  /// Returns a stone-accented scheme.
  ColorScheme get stone;
  /// Returns a red-accented scheme.
  ColorScheme get red;
  /// Returns an orange-accented scheme.
  ColorScheme get orange;
  /// Returns an amber-accented scheme.
  ColorScheme get amber;
  /// Returns a yellow-accented scheme.
  ColorScheme get yellow;
  /// Returns a lime-accented scheme.
  ColorScheme get lime;
  /// Returns a green-accented scheme.
  ColorScheme get green;
  /// Returns an emerald-accented scheme.
  ColorScheme get emerald;
  /// Returns a teal-accented scheme.
  ColorScheme get teal;
  /// Returns a cyan-accented scheme.
  ColorScheme get cyan;
  /// Returns a sky-accented scheme.
  ColorScheme get sky;
  /// Returns a blue-accented scheme.
  ColorScheme get blue;
  /// Returns an indigo-accented scheme.
  ColorScheme get indigo;
  /// Returns a violet-accented scheme.
  ColorScheme get violet;
  /// Returns a purple-accented scheme.
  ColorScheme get purple;
  /// Returns a fuchsia-accented scheme.
  ColorScheme get fuchsia;
  /// Returns a pink-accented scheme.
  ColorScheme get pink;
  /// Returns a rose-accented scheme.
  ColorScheme get rose;
}
```
