---
title: "Class: ControlledColorInput"
description: "A controlled color input widget integrating with form state management."
---

```dart
/// A controlled color input widget integrating with form state management.
///
/// Implements [ControlledComponent] to provide automatic form integration,
/// validation, and state management for color selection.
class ControlledColorInput extends StatelessWidget with ControlledComponent<ColorDerivative> {
  final ColorDerivative initialValue;
  final ValueChanged<ColorDerivative>? onChanged;
  final bool enabled;
  final ColorInputController? controller;
  /// Whether to show alpha channel controls.
  final bool? showAlpha;
  /// Alignment of the popover relative to the anchor.
  final AlignmentGeometry? popoverAlignment;
  /// Anchor alignment for the popover.
  final AlignmentGeometry? popoverAnchorAlignment;
  /// Padding inside the popover.
  final EdgeInsetsGeometry? popoverPadding;
  /// Placeholder widget when no color is selected.
  final Widget? placeholder;
  /// The prompt display mode for the color picker.
  final PromptMode? promptMode;
  /// Title widget for the dialog mode.
  final Widget? dialogTitle;
  /// Whether to show color labels.
  final bool? showLabel;
  /// Orientation of color controls.
  final Axis? orientation;
  /// Whether to enable the eye dropper tool.
  final bool? enableEyeDropper;
  /// The initial color picker mode to display.
  final ColorPickerMode? initialMode;
  /// Callback invoked while the color is being changed (live updates).
  final ValueChanged<ColorDerivative>? onChanging;
  /// Creates a controlled color input.
  const ControlledColorInput({super.key, required this.initialValue, this.onChanged, this.enabled = true, this.controller, this.showAlpha, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.placeholder, this.promptMode, this.dialogTitle, this.showLabel, this.orientation, this.enableEyeDropper, this.initialMode, this.onChanging});
  Widget build(BuildContext context);
}
```
