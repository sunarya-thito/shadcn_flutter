---
title: "Class: ColorShades"
description: "A collection of color shades from light to dark."
---

```dart
/// A collection of color shades from light to dark.
///
/// Implements both [Color] and [ColorSwatch] to provide a primary color
/// and access to different shade values (50, 100, 200, ..., 950).
class ColorShades implements Color, ColorSwatch {
  /// Standard shade values used in color palettes.
  ///
  /// Contains the standard Material Design shade values from lightest (50)
  /// to darkest (950): [50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950].
  static const List<int> shadeValues = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950];
  /// Creates color shades from a raw map.
  const ColorShades.raw(this._colors);
  /// Creates color shades from a sorted list of colors.
  ///
  /// The list must contain exactly 11 colors corresponding to shades
  /// 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, and 950.
  factory ColorShades.sorted(List<Color> colors);
  /// Creates color shades from an accent color.
  ///
  /// Generates a full shade range by shifting the accent color's HSL values.
  /// [base] is the shade value for the accent color (default: 500).
  /// [hueShift], [saturationStepDown], [saturationStepUp], [lightnessStepDown],
  /// and [lightnessStepUp] control how shades are generated.
  factory ColorShades.fromAccent(Color accent, {int base = 500, int hueShift = 0, int saturationStepDown = 0, int saturationStepUp = 0, int lightnessStepDown = 8, int lightnessStepUp = 9});
  /// Creates color shades from an accent HSL color.
  ///
  /// Similar to [fromAccent] but takes an HSL color directly.
  factory ColorShades.fromAccentHSL(HSLColor accent, {int base = 500, int hueShift = 0, int saturationStepDown = 0, int saturationStepUp = 0, int lightnessStepDown = 8, int lightnessStepUp = 9});
  /// Shifts an HSL color to a target shade value.
  ///
  /// Used internally to generate shade variations.
  static HSLColor shiftHSL(HSLColor hsv, int targetBase, {int base = 500, int hueShift = 0, int saturationStepUp = 0, int saturationStepDown = 0, int lightnessStepUp = 9, int lightnessStepDown = 8});
  /// Creates color shades from a map of shade values to colors.
  ///
  /// The map must contain all standard shade values (50-950).
  factory ColorShades.fromMap(Map<int, Color> colors);
  /// Gets the color for a specific shade value.
  Color get(int key);
  /// Gets the lightest shade (50).
  Color get shade50;
  /// Gets shade 100.
  Color get shade100;
  /// Gets shade 200.
  Color get shade200;
  /// Gets shade 300.
  Color get shade300;
  /// Gets shade 400.
  Color get shade400;
  /// Gets the medium/default shade (500).
  Color get shade500;
  /// Gets shade 600.
  Color get shade600;
  /// Gets shade 700.
  Color get shade700;
  /// Gets shade 800.
  Color get shade800;
  /// Gets shade 900.
  Color get shade900;
  /// Gets the darkest shade (950).
  Color get shade950;
  int get alpha;
  int get blue;
  double computeLuminance();
  int get green;
  double get opacity;
  int get red;
  int get value;
  ColorShades withAlpha(int a);
  ColorShades withBlue(int b);
  Color withGreen(int g);
  Color withOpacity(double opacity);
  Color withRed(int r);
  Color operator [](index);
  double get a;
  double get b;
  ColorSpace get colorSpace;
  double get g;
  Iterable get keys;
  double get r;
  Color withValues({double? alpha, double? red, double? green, double? blue, ColorSpace? colorSpace});
  int toARGB32();
}
```
