---
title: "Class: InputSpinnerFeature"
description: "Adds spinner controls (increment/decrement) to numeric input fields."
---

```dart
/// Adds spinner controls (increment/decrement) to numeric input fields.
///
/// Provides up/down buttons to adjust numeric values in fixed steps.
/// Optionally supports gesture-based adjustments (e.g., drag to change value).
///
/// Example:
/// ```dart
/// TextField(
///   keyboardType: TextInputType.number,
///   features: [
///     InputSpinnerFeature(
///       step: 5.0,
///       enableGesture: true,
///     ),
///   ],
/// )
/// ```
class InputSpinnerFeature extends InputFeature {
  /// The amount to increment or decrement on each step.
  final double step;
  /// Whether to enable gesture-based value adjustment.
  final bool enableGesture;
  /// Default value when the input is invalid or empty.
  final double? invalidValue;
  /// Creates an [InputSpinnerFeature].
  ///
  /// Parameters:
  /// - [step] (`double`, default: `1.0`): Increment/decrement step size.
  /// - [enableGesture] (`bool`, default: `true`): Enable drag gestures.
  /// - [invalidValue] (`double?`, default: `0.0`): Fallback value for invalid input.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputSpinnerFeature({super.visibility, super.skipFocusTraversal, this.step = 1.0, this.enableGesture = true, this.invalidValue = 0.0});
  InputFeatureState createState();
}
```
