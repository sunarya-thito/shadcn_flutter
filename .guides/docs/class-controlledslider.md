---
title: "Class: ControlledSlider"
description: "Reactive slider with automatic state management and controller support."
---

```dart
/// Reactive slider with automatic state management and controller support.
///
/// A high-level slider widget that provides automatic state management through
/// the controlled component pattern. Supports both single-value and range sliders
/// with comprehensive customization options for styling, behavior, and interaction.
///
/// ## Features
///
/// - **Single and range modes**: Unified interface for different slider types
/// - **Discrete divisions**: Optional snap-to-value behavior with tick marks
/// - **Keyboard navigation**: Full arrow key support with custom step sizes
/// - **Hint values**: Visual preview of suggested or default values
/// - **Accessibility support**: Screen reader compatibility and semantic labels
/// - **Form integration**: Automatic validation and form field registration
///
/// ## Usage Patterns
///
/// **Controller-based (recommended for complex state):**
/// ```dart
/// final controller = SliderController(SliderValue.single(0.5));
///
/// ControlledSlider(
///   controller: controller,
///   min: 0.0,
///   max: 100.0,
///   divisions: 100,
/// )
/// ```
///
/// **Callback-based (simple state management):**
/// ```dart
/// double currentValue = 50.0;
///
/// ControlledSlider(
///   initialValue: SliderValue.single(currentValue),
///   onChanged: (value) => setState(() => currentValue = value.single),
///   min: 0.0,
///   max: 100.0,
/// )
/// ```
class ControlledSlider extends StatelessWidget with ControlledComponent<SliderValue> {
  final SliderValue initialValue;
  final ValueChanged<SliderValue>? onChanged;
  final SliderController? controller;
  final bool enabled;
  final ValueChanged<SliderValue>? onChangeStart;
  final ValueChanged<SliderValue>? onChangeEnd;
  final double min;
  final double max;
  final int? divisions;
  final SliderValue? hintValue;
  final double? increaseStep;
  final double? decreaseStep;
  const ControlledSlider({super.key, this.controller, this.initialValue = const SliderValue.single(0), this.onChanged, this.onChangeStart, this.onChangeEnd, this.min = 0, this.max = 1, this.divisions, this.hintValue, this.increaseStep, this.decreaseStep, this.enabled = true});
  Widget build(BuildContext context);
}
```
