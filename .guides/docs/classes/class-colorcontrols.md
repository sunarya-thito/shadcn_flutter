---
title: "Class: ColorControls"
description: "Widget providing color input controls with multiple color space modes."
---

```dart
/// Widget providing color input controls with multiple color space modes.
///
/// Displays inputs for editing colors in RGB, HSL, HSV, or HEX formats
/// with optional alpha channel and eye dropper tool support.
class ColorControls extends StatelessWidget {
  /// The current color value.
  final ColorDerivative value;
  /// Callback invoked when the color is changed.
  final ValueChanged<ColorDerivative>? onChanged;
  /// Callback invoked while the color is being changed (live updates).
  final ValueChanged<ColorDerivative>? onChanging;
  /// Callback invoked when the color picker mode changes.
  final ValueChanged<ColorPickerMode>? onModeChanged;
  /// Whether to show alpha channel controls.
  final bool showAlpha;
  /// The current color picker mode (RGB, HSL, HSV, or HEX).
  final ColorPickerMode mode;
  /// Spacing between control elements.
  final double? controlSpacing;
  /// Whether to enable the eye dropper tool.
  final bool? enableEyeDropper;
  /// Callback invoked when the eye dropper tool is requested.
  final VoidCallback? onEyeDropperRequested;
  /// Creates color controls.
  const ColorControls({super.key, required this.value, this.onChanged, this.onChanging, this.onModeChanged, this.showAlpha = false, this.mode = ColorPickerMode.rgb, this.enableEyeDropper, this.onEyeDropperRequested, this.controlSpacing});
  Widget build(BuildContext context);
  /// Builds the input widgets based on the current color picker mode.
  List<Widget> buildInputs(BuildContext context);
  /// Builds RGB color input widgets.
  List<Widget> buildRGBInputs(BuildContext context);
  /// Builds HSL color input widgets.
  List<Widget> buildHSLInputs(BuildContext context);
  /// Builds HSV color input widgets.
  List<Widget> buildHSVInputs(BuildContext context);
  /// Builds HEX color input widgets.
  List<Widget> buildHEXInputs(BuildContext context);
}
```
