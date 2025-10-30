---
title: "Class: ColorDerivative"
description: "Reference for ColorDerivative"
---

```dart
abstract class ColorDerivative {
  static ColorDerivative fromColor(Color color);
  factory ColorDerivative.fromHSV(HSVColor color);
  factory ColorDerivative.fromHSL(HSLColor color);
  const ColorDerivative();
  Color toColor();
  HSVColor toHSVColor();
  HSLColor toHSLColor();
  double get opacity;
  double get hslHue;
  double get hslSat;
  double get hslVal;
  double get hsvHue;
  double get hsvSat;
  double get hsvVal;
  int get red;
  int get green;
  int get blue;
  ColorDerivative transform(ColorDerivative old);
  ColorDerivative changeToOpacity(double alpha);
  ColorDerivative changeToColor(Color color);
  ColorDerivative changeToHSV(HSVColor color);
  ColorDerivative changeToHSL(HSLColor color);
  ColorDerivative changeToColorRed(double red);
  ColorDerivative changeToColorGreen(double green);
  ColorDerivative changeToColorBlue(double blue);
  ColorDerivative changeToHSVHue(double hue);
  ColorDerivative changeToHSVSaturation(double saturation);
  ColorDerivative changeToHSVValue(double value);
  ColorDerivative changeToHSVAlpha(double alpha);
  ColorDerivative changeToHSLHue(double hue);
  ColorDerivative changeToHSLSaturation(double saturation);
  ColorDerivative changeToHSLLightness(double lightness);
}
```
