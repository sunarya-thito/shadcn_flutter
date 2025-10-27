---
title: "Class: ControlledColorInput"
description: "Reactive color input with automatic state management and controller support."
---

```dart
/// Reactive color input with automatic state management and controller support.
///
/// A high-level color picker widget that provides automatic state management through
/// the controlled component pattern. Supports both controller-based and callback-based
/// state management with comprehensive customization options for color picker presentation,
/// interaction modes, and visual styling.
///
/// ## Features
///
/// - **Multiple picker modes**: HSV, HSL, and RGB color picker interfaces
/// - **Alpha channel support**: Optional transparency/opacity controls
/// - **Screen color sampling**: Pick colors directly from screen (platform dependent)
/// - **Color history**: Automatic recent color tracking and storage
/// - **Flexible presentation**: Popover or modal dialog interaction modes
/// - **Accessibility support**: Full keyboard navigation and screen reader compatibility
///
/// ## Usage Patterns
///
/// **Controller-based (recommended for complex state):**
/// ```dart
/// final controller = ColorInputController(
///   ColorDerivative.fromColor(Colors.blue),
/// );
///
/// ControlledColorInput(
///   controller: controller,
///   showAlpha: true,
///   allowPickFromScreen: true,
///   pickerMode: ColorPickerMode.hsv,
/// )
/// ```
///
/// **Callback-based (simple state management):**
/// ```dart
/// ColorDerivative currentColor = ColorDerivative.fromColor(Colors.red);
///
/// ControlledColorInput(
///   initialValue: currentColor,
///   onChanged: (color) => setState(() => currentColor = color),
///   mode: PromptMode.popover,
/// )
/// ```
class ControlledColorInput extends StatelessWidget with ControlledComponent<ColorDerivative> {
  final ColorDerivative initialValue;
  final ValueChanged<ColorDerivative>? onChanged;
  final bool enabled;
  final ColorInputController? controller;
  final bool? showAlpha;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final EdgeInsetsGeometry? popoverPadding;
  final Widget? placeholder;
  final PromptMode? mode;
  final ColorPickerMode? pickerMode;
  final Widget? dialogTitle;
  final bool? allowPickFromScreen;
  final bool? showLabel;
  final ColorHistoryStorage? storage;
  const ControlledColorInput({super.key, this.initialValue = const ColorDerivative.fromHSV(HSVColor.fromAHSV(0, 0, 0, 0)), this.onChanged, this.controller, this.enabled = true, this.showAlpha, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.placeholder, this.mode, this.pickerMode, this.dialogTitle, this.allowPickFromScreen, this.showLabel, this.storage});
  Widget build(BuildContext context);
}
```
