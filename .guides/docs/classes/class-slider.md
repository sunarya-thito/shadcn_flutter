---
title: "Class: Slider"
description: "A Material Design slider widget for selecting values or ranges."
---

```dart
/// A Material Design slider widget for selecting values or ranges.
///
/// A highly customizable slider supporting both single-value and range
/// selection modes. Provides keyboard navigation, discrete divisions,
/// hint values, and comprehensive theming options.
///
/// Unlike [ControlledSlider], this widget is uncontrolled and requires
/// explicit value management through [onChanged]. For a controlled
/// alternative with automatic state management, use [ControlledSlider].
///
/// Example:
/// ```dart
/// Slider(
///   value: SliderValue.single(0.5),
///   min: 0.0,
///   max: 1.0,
///   divisions: 10,
///   onChanged: (newValue) {
///     setState(() => value = newValue);
///   },
/// )
/// ```
class Slider extends StatefulWidget {
  /// The current value of the slider.
  ///
  /// Can be either a single value or a range. The slider's visual state
  /// reflects this value.
  final SliderValue value;
  /// Callback invoked when the slider value changes.
  ///
  /// Called repeatedly during slider interaction as the user drags the thumb
  /// or clicks the track. Receives the new [SliderValue].
  final ValueChanged<SliderValue>? onChanged;
  /// Callback invoked when the user starts changing the slider value.
  ///
  /// Called once when interaction begins. Receives the initial [SliderValue].
  final ValueChanged<SliderValue>? onChangeStart;
  /// Callback invoked when the user finishes changing the slider value.
  ///
  /// Called once when interaction ends. Receives the final [SliderValue].
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
  /// If `null`, the slider is continuous. If specified, the slider snaps to
  /// discrete values.
  final int? divisions;
  /// An optional hint value displayed on the slider track.
  ///
  /// Renders as a visual marker showing a target or reference position.
  final SliderValue? hintValue;
  /// The step size for keyboard increment actions.
  ///
  /// Used when the user triggers increase actions via keyboard. If `null`,
  /// a default step is calculated based on the slider range.
  final double? increaseStep;
  /// The step size for keyboard decrement actions.
  ///
  /// Used when the user triggers decrease actions via keyboard. If `null`,
  /// a default step is calculated based on the slider range.
  final double? decreaseStep;
  /// Whether the slider is interactive.
  ///
  /// When `false` or `null` with no [onChanged] callback, the slider is
  /// displayed in a disabled state and does not respond to user input.
  final bool? enabled;
  /// Creates a [Slider].
  ///
  /// Parameters:
  /// - [value] (`SliderValue`, required): Current slider value.
  /// - [onChanged] (`ValueChanged<SliderValue>?`, optional): Value change callback.
  /// - [onChangeStart] (`ValueChanged<SliderValue>?`, optional): Interaction start callback.
  /// - [onChangeEnd] (`ValueChanged<SliderValue>?`, optional): Interaction end callback.
  /// - [min] (`double`, default: `0`): Minimum value.
  /// - [max] (`double`, default: `1`): Maximum value.
  /// - [divisions] (`int?`, optional): Number of discrete divisions.
  /// - [hintValue] (`SliderValue?`, optional): Visual hint marker.
  /// - [increaseStep] (`double?`, optional): Keyboard increment step.
  /// - [decreaseStep] (`double?`, optional): Keyboard decrement step.
  /// - [enabled] (`bool?`, optional): Whether interactive.
  ///
  /// Example:
  /// ```dart
  /// Slider(
  ///   value: SliderValue.ranged(0.2, 0.8),
  ///   min: 0.0,
  ///   max: 1.0,
  ///   onChanged: (value) => print('Range: ${value.start}-${value.end}'),
  /// )
  /// ```
  const Slider({super.key, required this.value, this.onChanged, this.onChangeStart, this.onChangeEnd, this.min = 0, this.max = 1, this.divisions, this.hintValue, this.increaseStep, this.decreaseStep, this.enabled = true});
  State<Slider> createState();
}
```
