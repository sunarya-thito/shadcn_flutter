---
title: "Class: ColorDerivative"
description: "An abstract base class representing a color that can be transformed between different color spaces."
---

```dart
/// An abstract base class representing a color that can be transformed between different color spaces.
///
/// [ColorDerivative] provides a unified interface for working with colors in various color spaces
/// (HSV, HSL, RGB) while maintaining transformation capabilities. This is particularly useful
/// in color picker implementations where users may want to work with different color models.
///
/// The class supports:
/// - Conversion between HSV, HSL, and RGB color spaces
/// - Individual channel manipulation (hue, saturation, value/lightness, red, green, blue, opacity)
/// - Preserving the internal color representation when transforming
///
/// Example:
/// ```dart
/// // Create from a Flutter Color
/// final derivative = ColorDerivative.fromColor(Colors.blue);
/// 
/// // Modify saturation
/// final desaturated = derivative.changeToHSVSaturation(0.5);
/// 
/// // Convert back to Color
/// final newColor = desaturated.toColor();
/// ```
abstract class ColorDerivative {
  /// Creates a [ColorDerivative] from a Flutter [Color] using HSV color space internally.
  static ColorDerivative fromColor(Color color);
  /// Creates a [ColorDerivative] from an [HSVColor].
  factory ColorDerivative.fromHSV(HSVColor color);
  /// Creates a [ColorDerivative] from an [HSLColor].
  factory ColorDerivative.fromHSL(HSLColor color);
  /// Creates a const [ColorDerivative].
  const ColorDerivative();
  /// Converts this color derivative to a Flutter [Color].
  Color toColor();
  /// Converts this color derivative to an [HSVColor].
  HSVColor toHSVColor();
  /// Converts this color derivative to an [HSLColor].
  HSLColor toHSLColor();
  /// Gets the opacity (alpha) value of this color, ranging from 0.0 to 1.0.
  double get opacity;
  /// Gets the hue component in HSL color space, ranging from 0.0 to 360.0.
  double get hslHue;
  /// Gets the saturation component in HSL color space, ranging from 0.0 to 1.0.
  double get hslSat;
  /// Gets the lightness component in HSL color space, ranging from 0.0 to 1.0.
  double get hslVal;
  /// Gets the hue component in HSV color space, ranging from 0.0 to 360.0.
  double get hsvHue;
  /// Gets the saturation component in HSV color space, ranging from 0.0 to 1.0.
  double get hsvSat;
  /// Gets the value (brightness) component in HSV color space, ranging from 0.0 to 1.0.
  double get hsvVal;
  /// Gets the red component in RGB color space, ranging from 0 to 255.
  int get red;
  /// Gets the green component in RGB color space, ranging from 0 to 255.
  int get green;
  /// Gets the blue component in RGB color space, ranging from 0 to 255.
  int get blue;
  /// Transforms this color derivative to match the internal representation of [old].
  ///
  /// This method preserves the color space representation (HSV or HSL) used by [old]
  /// while applying the color values from this derivative. This is useful when
  /// maintaining consistency in color space during transformations.
  ColorDerivative transform(ColorDerivative old);
  /// Changes the opacity (alpha) value of this color.
  ///
  /// Parameters:
  /// - [alpha]: The new opacity value, ranging from 0.0 (fully transparent) to 1.0 (fully opaque).
  ///
  /// Returns: A new [ColorDerivative] with the updated opacity.
  ColorDerivative changeToOpacity(double alpha);
  /// Changes this color to the specified [color] while preserving the internal color space representation.
  ///
  /// Parameters:
  /// - [color]: The target color to change to.
  ///
  /// Returns: A new [ColorDerivative] with the new color value.
  ColorDerivative changeToColor(Color color);
  /// Changes this color to the specified [color] in HSV color space.
  ///
  /// Parameters:
  /// - [color]: The target HSV color to change to.
  ///
  /// Returns: A new [ColorDerivative] with the new HSV color value.
  ColorDerivative changeToHSV(HSVColor color);
  /// Changes this color to the specified [color] in HSL color space.
  ///
  /// Parameters:
  /// - [color]: The target HSL color to change to.
  ///
  /// Returns: A new [ColorDerivative] with the new HSL color value.
  ColorDerivative changeToHSL(HSLColor color);
  /// Changes the red component of this color in RGB color space.
  ///
  /// Parameters:
  /// - [red]: The new red value, ranging from 0.0 to 255.0.
  ///
  /// Returns: A new [ColorDerivative] with the updated red component.
  ColorDerivative changeToColorRed(double red);
  /// Changes the green component of this color in RGB color space.
  ///
  /// Parameters:
  /// - [green]: The new green value, ranging from 0.0 to 255.0.
  ///
  /// Returns: A new [ColorDerivative] with the updated green component.
  ColorDerivative changeToColorGreen(double green);
  /// Changes the blue component of this color in RGB color space.
  ///
  /// Parameters:
  /// - [blue]: The new blue value, ranging from 0.0 to 255.0.
  ///
  /// Returns: A new [ColorDerivative] with the updated blue component.
  ColorDerivative changeToColorBlue(double blue);
  /// Changes the hue component of this color in HSV color space.
  ///
  /// Parameters:
  /// - [hue]: The new hue value, ranging from 0.0 to 360.0 degrees.
  ///
  /// Returns: A new [ColorDerivative] with the updated HSV hue.
  ColorDerivative changeToHSVHue(double hue);
  /// Changes the saturation component of this color in HSV color space.
  ///
  /// Parameters:
  /// - [saturation]: The new saturation value, ranging from 0.0 to 1.0.
  ///
  /// Returns: A new [ColorDerivative] with the updated HSV saturation.
  ColorDerivative changeToHSVSaturation(double saturation);
  /// Changes the value (brightness) component of this color in HSV color space.
  ///
  /// Parameters:
  /// - [value]: The new value component, ranging from 0.0 to 1.0.
  ///
  /// Returns: A new [ColorDerivative] with the updated HSV value.
  ColorDerivative changeToHSVValue(double value);
  /// Changes the alpha (opacity) component of this color in HSV color space.
  ///
  /// Parameters:
  /// - [alpha]: The new alpha value, ranging from 0.0 (fully transparent) to 1.0 (fully opaque).
  ///
  /// Returns: A new [ColorDerivative] with the updated HSV alpha.
  ColorDerivative changeToHSVAlpha(double alpha);
  /// Changes the hue component of this color in HSL color space.
  ///
  /// Parameters:
  /// - [hue]: The new hue value, ranging from 0.0 to 360.0 degrees.
  ///
  /// Returns: A new [ColorDerivative] with the updated HSL hue.
  ColorDerivative changeToHSLHue(double hue);
  /// Changes the saturation component of this color in HSL color space.
  ///
  /// Parameters:
  /// - [saturation]: The new saturation value, ranging from 0.0 to 1.0.
  ///
  /// Returns: A new [ColorDerivative] with the updated HSL saturation.
  ColorDerivative changeToHSLSaturation(double saturation);
  /// Changes the lightness component of this color in HSL color space.
  ///
  /// Parameters:
  /// - [lightness]: The new lightness value, ranging from 0.0 to 1.0.
  ///
  /// Returns: A new [ColorDerivative] with the updated HSL lightness.
  ColorDerivative changeToHSLLightness(double lightness);
}
```
