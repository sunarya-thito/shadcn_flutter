---
title: "Class: ColorInputTheme"
description: "Theme configuration for [ColorInput] widget styling and behavior."
---

```dart
/// Theme configuration for [ColorInput] widget styling and behavior.
///
/// Defines the visual properties and default behaviors for color input components
/// including popover presentation, picker modes, and interaction features. Applied
/// globally through [ComponentTheme] or per-instance for customization.
///
/// Supports comprehensive customization of color picker appearance, positioning,
/// and functionality to match application design requirements.
class ColorInputTheme {
  /// Whether to display alpha (transparency) controls by default.
  ///
  /// When true, color pickers include alpha/opacity sliders and inputs.
  /// When false, only RGB/HSV controls are shown. Individual components
  /// can override this theme setting.
  final bool? showAlpha;
  /// Alignment point on the popover for anchor attachment.
  ///
  /// Determines where the color picker popover positions itself relative
  /// to the anchor widget. When null, uses framework default alignment.
  final AlignmentGeometry? popoverAlignment;
  /// Alignment point on the anchor widget for popover positioning.
  ///
  /// Specifies which part of the trigger widget the popover should align to.
  /// When null, uses framework default anchor alignment.
  final AlignmentGeometry? popoverAnchorAlignment;
  /// Internal padding applied to the color picker popover content.
  ///
  /// Controls spacing around the color picker interface within the popover
  /// container. When null, uses framework default padding.
  final EdgeInsetsGeometry? popoverPadding;
  /// Default interaction mode for color input triggers.
  ///
  /// Determines whether color selection opens a popover or modal dialog.
  /// When null, uses framework default prompt mode behavior.
  final PromptMode? mode;
  /// Default color picker interface type.
  ///
  /// Specifies whether to use HSV, HSL, or other color picker implementations.
  /// When null, uses framework default picker mode.
  final ColorPickerMode? pickerMode;
  /// Whether to enable screen color sampling functionality.
  ///
  /// When true, color pickers include tools to sample colors directly from
  /// the screen. Platform support varies. When null, uses framework default.
  final bool? enableEyeDropper;
  /// Whether to display color value labels in picker interfaces.
  ///
  /// When true, shows numeric color values (hex, RGB, HSV, etc.) alongside
  /// visual color pickers. When null, uses framework default label visibility.
  final bool? showLabel;
  /// The orientation of the color input layout.
  final Axis? orientation;
  /// Creates a [ColorInputTheme].
  ///
  /// All parameters are optional and fall back to framework defaults when null.
  /// The theme can be applied globally or to specific color input instances.
  const ColorInputTheme({this.showAlpha, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.mode, this.pickerMode, this.enableEyeDropper, this.showLabel, this.orientation});
  /// Creates a copy of this theme with specified properties overridden.
  ///
  /// Each parameter function is called only if provided, allowing selective
  /// overrides while preserving existing values for unspecified properties.
  ColorInputTheme copyWith({ValueGetter<bool?>? showAlpha, ValueGetter<AlignmentGeometry?>? popoverAlignment, ValueGetter<AlignmentGeometry?>? popoverAnchorAlignment, ValueGetter<EdgeInsetsGeometry?>? popoverPadding, ValueGetter<PromptMode?>? mode, ValueGetter<ColorPickerMode?>? pickerMode, ValueGetter<bool?>? enableEyeDropper, ValueGetter<bool?>? showLabel, ValueGetter<Axis?>? orientation});
  bool operator ==(Object other);
  int get hashCode;
}
```
