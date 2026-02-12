---
title: "Class: InputStepperButtonFeature"
description: "Adds a single increment button to numeric input fields.   Provides a button that increases the numeric value by a fixed step."
---

```dart
/// Adds a single increment button to numeric input fields.
///
/// Provides a button that increases the numeric value by a fixed step.
class InputStepperButtonFeature extends InputFeature {
  /// The amount to increment on each press.
  final double step;
  /// Default value when the input is invalid or empty.
  final double? invalidValue;
  /// Minimum allowed value.
  final double? min;
  /// Maximum allowed value.
  final double? max;
  /// Position of the increment button.
  final InputFeaturePosition position;
  /// Custom icon for the increment button.
  final Widget? icon;
  /// Creates an [InputStepperButtonFeature].
  ///
  /// Parameters:
  /// - [step] (`double`, default: `1.0`): Increment step size.
  /// - [invalidValue] (`double?`, default: `0.0`): Fallback value for invalid input.
  /// - [min] (`double?`, optional): Minimum allowed value.
  /// - [max] (`double?`, optional): Maximum allowed value.
  /// - [position] (`InputFeaturePosition`, default: `InputFeaturePosition.trailing`):
  ///   Where to place the button.
  /// - [icon] (`Widget?`, optional): Custom icon widget.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputStepperButtonFeature({super.visibility, super.skipFocusTraversal, this.step = 1.0, this.invalidValue = 0.0, this.min, this.max, this.position = InputFeaturePosition.trailing, this.icon = const Icon(LucideIcons.plus)});
  /// Creates a decrement button feature for numeric inputs.
  ///
  /// Parameters:
  /// - [step] (`double`, default: `-1.0`): Decrement step size.
  /// - [invalidValue] (`double?`, default: `0.0`): Fallback value for invalid input.
  /// - [min] (`double?`, optional): Minimum allowed value.
  /// - [max] (`double?`, optional): Maximum allowed value.
  /// - [position] (`InputFeaturePosition`, default: `InputFeaturePosition.trailing`):
  ///   Where to place the button.
  /// - [icon] (`Widget?`, optional): Custom icon widget.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputStepperButtonFeature.decrement({super.visibility, super.skipFocusTraversal, this.step = -1.0, this.invalidValue = 0.0, this.min, this.max, this.position = InputFeaturePosition.trailing, this.icon = const Icon(LucideIcons.minus)});
  InputFeatureState createState();
}
```
