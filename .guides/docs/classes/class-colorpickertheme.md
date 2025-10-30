---
title: "Class: ColorPickerTheme"
description: "Theme configuration for [ColorPicker] widget styling and layout."
---

```dart
/// Theme configuration for [ColorPicker] widget styling and layout.
///
/// Defines visual and layout properties for color picker components including
/// spacing, orientation, and feature availability. Applied globally through
/// [ComponentTheme] or per-instance.
class ColorPickerTheme {
  /// Spacing between major color picker sections.
  final double? spacing;
  /// Spacing between individual controls within sections.
  final double? controlSpacing;
  /// Layout orientation (horizontal or vertical).
  final Axis? orientation;
  /// Whether to enable the eye dropper feature.
  final bool? enableEyeDropper;
  /// The size of color sliders.
  final double? sliderSize;
  /// Creates a [ColorPickerTheme].
  const ColorPickerTheme({this.spacing, this.controlSpacing, this.orientation, this.enableEyeDropper, this.sliderSize});
  /// Creates a copy of this theme with specified properties overridden.
  ColorPickerTheme copyWith({ValueGetter<double?>? spacing, ValueGetter<double?>? controlSpacing, ValueGetter<Axis?>? orientation, ValueGetter<bool?>? enableEyeDropper, ValueGetter<double?>? sliderSize});
  bool operator ==(Object other);
  int get hashCode;
}
```
