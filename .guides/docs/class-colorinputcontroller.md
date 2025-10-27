---
title: "Class: ColorInputController"
description: "Reactive controller for managing color input state with color operations."
---

```dart
/// Reactive controller for managing color input state with color operations.
///
/// Extends [ValueNotifier] to provide state management for color input widgets
/// using [ColorDerivative] values that support multiple color space representations.
/// Enables programmatic color changes while maintaining color space fidelity.
///
/// The controller manages [ColorDerivative] objects which preserve original
/// color space information (HSV, HSL, RGB) for accurate color manipulations
/// and prevents precision loss during color space conversions.
///
/// Example:
/// ```dart
/// final controller = ColorInputController(
///   ColorDerivative.fromColor(Colors.blue),
/// );
///
/// // React to changes
/// controller.addListener(() {
///   print('Color changed to: ${controller.value.color}');
/// });
///
/// // Programmatic control
/// controller.value = ColorDerivative.fromHSV(HSVColor.fromColor(Colors.red));
/// ```
class ColorInputController extends ValueNotifier<ColorDerivative> with ComponentController<ColorDerivative> {
  /// Creates a [ColorInputController] with the specified initial color.
  ///
  /// The [value] parameter provides the initial color as a [ColorDerivative].
  /// The controller notifies listeners when the color changes through any
  /// method calls or direct value assignment.
  ///
  /// Example:
  /// ```dart
  /// final controller = ColorInputController(
  ///   ColorDerivative.fromColor(Colors.green),
  /// );
  /// ```
  ColorInputController(super.value);
  /// Sets the color to a new [Color] value.
  ///
  /// Converts the color to a [ColorDerivative] preserving RGB color space
  /// information. Notifies listeners of the change.
  void setColor(Color color);
  /// Sets the color to a new HSV color value.
  ///
  /// Uses [ColorDerivative.fromHSV] to preserve HSV color space information
  /// for accurate hue, saturation, and value manipulations.
  void setHSVColor(HSVColor hsvColor);
  /// Sets the color to a new HSL color value.
  ///
  /// Uses [ColorDerivative.fromHSL] to preserve HSL color space information
  /// for accurate hue, saturation, and lightness manipulations.
  void setHSLColor(HSLColor hslColor);
  /// Gets the current color as a standard [Color] object.
  Color get color;
  /// Gets the current color as an HSV color representation.
  HSVColor get hsvColor;
  /// Gets the current color as an HSL color representation.
  HSLColor get hslColor;
}
```
