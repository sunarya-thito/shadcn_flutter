---
title: "Class: ColorShades"
description: "Reference for ColorShades"
---

```dart
class ColorShades implements Color, ColorSwatch {
  static const List<int> shadeValues = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950];
  const ColorShades.raw(this._colors);
  factory ColorShades.sorted(List<Color> colors);
  factory ColorShades.fromAccent(Color accent, {int base = 500, int hueShift = 0, int saturationStepDown = 0, int saturationStepUp = 0, int lightnessStepDown = 8, int lightnessStepUp = 9});
  factory ColorShades.fromAccentHSL(HSLColor accent, {int base = 500, int hueShift = 0, int saturationStepDown = 0, int saturationStepUp = 0, int lightnessStepDown = 8, int lightnessStepUp = 9});
  static HSLColor shiftHSL(HSLColor hsv, int targetBase, {int base = 500, int hueShift = 0, int saturationStepUp = 0, int saturationStepDown = 0, int lightnessStepUp = 9, int lightnessStepDown = 8});
  factory ColorShades.fromMap(Map<int, Color> colors);
  Color get(int key);
  Color get shade50;
  Color get shade100;
  Color get shade200;
  Color get shade300;
  Color get shade400;
  Color get shade500;
  Color get shade600;
  Color get shade700;
  Color get shade800;
  Color get shade900;
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
