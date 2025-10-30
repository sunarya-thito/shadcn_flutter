---
title: "Class: ColorInput"
description: "A color input widget that allows users to select and edit colors."
---

```dart
/// A color input widget that allows users to select and edit colors.
///
/// [ColorInput] provides a comprehensive color selection interface with support
/// for multiple color spaces (HSV, HSL), alpha channel control, and eye dropper
/// functionality. The widget can be displayed in a popover or modal dialog.
///
/// The color picker supports:
/// - Multiple color representation modes (HSV, HSL)
/// - Optional alpha/opacity control
/// - Screen color sampling with eye dropper
/// - Customizable layout orientation
/// - Flexible positioning via popovers or dialogs
///
/// Example:
/// ```dart
/// ColorInput(
///   value: ColorDerivative.fromColor(Colors.blue),
///   onChanged: (color) {
///     print('Selected color: ${color.toColor()}');
///   },
///   showAlpha: true,
///   enableEyeDropper: true,
/// )
/// ```
class ColorInput extends StatefulWidget {
  /// The current color value.
  final ColorDerivative value;
  /// Called when the color is being changed (while dragging sliders, etc.).
  final ValueChanged<ColorDerivative>? onChanging;
  /// Called when the color change is complete (after releasing sliders, etc.).
  final ValueChanged<ColorDerivative>? onChanged;
  /// Whether to show alpha (opacity) controls.
  final bool? showAlpha;
  /// The initial color picker mode (HSV, HSL, etc.).
  final ColorPickerMode? initialMode;
  /// Whether to enable the eye dropper (screen color sampling) feature.
  final bool? enableEyeDropper;
  /// The alignment of the popover relative to the anchor.
  final AlignmentGeometry? popoverAlignment;
  /// The alignment point on the anchor widget for popover positioning.
  final AlignmentGeometry? popoverAnchorAlignment;
  /// Internal padding for the popover content.
  final EdgeInsetsGeometry? popoverPadding;
  /// Widget displayed when no color is selected.
  final Widget? placeholder;
  /// The mode for presenting the color picker (popover or modal).
  final PromptMode? promptMode;
  /// Title widget for the dialog when using modal mode.
  final Widget? dialogTitle;
  /// Whether to show color value labels.
  final bool? showLabel;
  /// Whether the color input is enabled.
  final bool? enabled;
  /// The layout orientation of the color input.
  final Axis? orientation;
  /// Creates a [ColorInput] widget.
  const ColorInput({super.key, required this.value, this.onChanging, this.onChanged, this.showAlpha, this.initialMode, this.enableEyeDropper = true, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.placeholder, this.promptMode, this.dialogTitle, this.showLabel, this.orientation, this.enabled});
  State<ColorInput> createState();
}
```
