---
title: "Class: ColorPicker"
description: "A comprehensive color picker widget with multiple color mode support."
---

```dart
/// A comprehensive color picker widget with multiple color mode support.
///
/// [ColorPicker] provides an interactive interface for selecting colors using
/// various color representation models (RGB, HSL, HSV, HEX). It supports alpha
/// channel control, eye dropper functionality, and customizable layout.
///
/// Features:
/// - Multiple color modes (RGB, HSL, HSV, HEX)
/// - Optional alpha/opacity control
/// - Screen color sampling with eye dropper
/// - Flexible layout orientation
/// - Real-time color updates
/// - Mode switching during use
///
/// Example:
/// ```dart
/// ColorPicker(
///   value: ColorDerivative.fromColor(Colors.blue),
///   onChanged: (color) {
///     print('Selected: ${color.toColor()}');
///   },
///   showAlpha: true,
///   initialMode: ColorPickerMode.hsv,
///   enableEyeDropper: true,
/// )
/// ```
class ColorPicker extends StatefulWidget {
  /// The current color value.
  final ColorDerivative value;
  /// Called when the color is finalized.
  final ValueChanged<ColorDerivative>? onChanged;
  /// Called continuously while the color is being changed.
  final ValueChanged<ColorDerivative>? onChanging;
  /// Whether to show alpha (opacity) controls.
  final bool showAlpha;
  /// The initial color picker mode.
  final ColorPickerMode initialMode;
  /// Called when the color picker mode changes.
  final ValueChanged<ColorPickerMode>? onModeChanged;
  /// Called when the eye dropper button is pressed.
  final VoidCallback? onEyeDropperRequested;
  /// Whether to enable the eye dropper feature.
  final bool? enableEyeDropper;
  /// Layout orientation of the color picker.
  final Axis? orientation;
  /// Spacing between major sections.
  final double? spacing;
  /// Spacing between individual controls.
  final double? controlSpacing;
  /// Size of the color sliders.
  final double? sliderSize;
  /// Creates a [ColorPicker] widget.
  const ColorPicker({super.key, required this.value, this.onChanged, this.onChanging, this.showAlpha = false, this.initialMode = ColorPickerMode.rgb, this.onModeChanged, this.enableEyeDropper, this.onEyeDropperRequested, this.orientation, this.spacing, this.controlSpacing, this.sliderSize});
  State<ColorPicker> createState();
}
```
