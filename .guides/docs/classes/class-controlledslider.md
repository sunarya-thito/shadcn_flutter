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
  /// Callback invoked when the user starts changing the slider value.
  ///
  /// Called once when the user begins dragging the slider thumb or interacting
  /// with the slider track. Receives the initial [SliderValue] at the start of
  /// the interaction.
  final ValueChanged<SliderValue>? onChangeStart;
  /// Callback invoked when the user finishes changing the slider value.
  ///
  /// Called once when the user releases the slider thumb or completes the
  /// interaction. Receives the final [SliderValue] at the end of the interaction.
  final ValueChanged<SliderValue>? onChangeEnd;
  /// The minimum value the slider can represent.
  ///
  /// Defaults to `0`. Must be less than [max].
  final double min;
  /// The maximum value the slider can represent.
  ///
  /// Defaults to `1`. Must be greater than [min].
  final double max;
  /// The number of discrete divisions the slider range is divided into.
  ///
  /// If `null`, the slider is continuous. If non-null, the slider will snap to
  /// discrete values in the range `[min, max]`.
  final int? divisions;
  /// An optional hint value displayed on the slider track.
  ///
  /// Provides visual feedback showing a target or reference value. The hint is
  /// typically rendered as a subtle marker on the track.
  final SliderValue? hintValue;
  /// The step size for keyboard increment actions.
  ///
  /// When the user presses the increase key, the slider value will increase by
  /// this amount. If `null`, a default increment is used.
  final double? increaseStep;
  /// The step size for keyboard decrement actions.
  ///
  /// When the user presses the decrease key, the slider value will decrease by
  /// this amount. If `null`, a default decrement is used.
  final double? decreaseStep;
  /// Creates a [ControlledSlider].
  ///
  /// A controlled slider that manages its state either through an external
  /// [controller] or internal state with [initialValue]. Use this when you need
  /// programmatic control over the slider value.
  ///
  /// Parameters:
  /// - [controller] (`SliderController?`, optional): External controller for
  ///   managing slider state. If provided, it becomes the source of truth.
  /// - [initialValue] (`SliderValue`, default: `SliderValue.single(0)`): Initial
  ///   value when no controller is provided.
  /// - [onChanged] (`ValueChanged<SliderValue>?`, optional): Called when the
  ///   slider value changes during interaction.
  /// - [onChangeStart] (`ValueChanged<SliderValue>?`, optional): Called when the
  ///   user begins interaction.
  /// - [onChangeEnd] (`ValueChanged<SliderValue>?`, optional): Called when the
  ///   user completes interaction.
  /// - [min] (`double`, default: `0`): Minimum slider value.
  /// - [max] (`double`, default: `1`): Maximum slider value.
  /// - [divisions] (`int?`, optional): Number of discrete divisions. If `null`,
  ///   the slider is continuous.
  /// - [hintValue] (`SliderValue?`, optional): Visual hint marker on the track.
  /// - [increaseStep] (`double?`, optional): Keyboard increment step size.
  /// - [decreaseStep] (`double?`, optional): Keyboard decrement step size.
  /// - [enabled] (`bool`, default: `true`): Whether the slider is interactive.
  ///
  /// Example:
  /// ```dart
  /// final controller = SliderController(SliderValue.single(0.5));
  ///
  /// ControlledSlider(
  ///   controller: controller,
  ///   min: 0.0,
  ///   max: 100.0,
  ///   divisions: 100,
  ///   onChanged: (value) => print('Value: $value'),
  /// )
  /// ```
  const ControlledSlider({super.key, this.controller, this.initialValue = const SliderValue.single(0), this.onChanged, this.onChangeStart, this.onChangeEnd, this.min = 0, this.max = 1, this.divisions, this.hintValue, this.increaseStep, this.decreaseStep, this.enabled = true});
  Widget build(BuildContext context);
}
```
