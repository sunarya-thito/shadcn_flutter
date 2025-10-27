---
title: "Class: SliderController"
description: "Reactive controller for managing slider state with value operations."
---

```dart
/// Reactive controller for managing slider state with value operations.
///
/// Extends [ValueNotifier] to provide state management for slider widgets
/// using [SliderValue] objects that support both single and range slider
/// configurations. Enables programmatic slider value changes and provides
/// convenient methods for common slider operations.
///
/// The controller manages [SliderValue] objects which can represent either
/// single values or dual-thumb range values, providing unified state management
/// for different slider types.
///
/// Example:
/// ```dart
/// final controller = SliderController(SliderValue.single(0.5));
///
/// // React to changes
/// controller.addListener(() {
///   print('Slider value: ${controller.value}');
/// });
///
/// // Programmatic control
/// controller.setValue(0.75);
/// controller.setRange(0.2, 0.8);
/// ```
class SliderController extends ValueNotifier<SliderValue> with ComponentController<SliderValue> {
  /// Creates a [SliderController] with the specified initial value.
  ///
  /// The [value] parameter provides the initial slider configuration as a
  /// [SliderValue]. The controller notifies listeners when the value changes
  /// through any method calls or direct value assignment.
  ///
  /// Example:
  /// ```dart
  /// final controller = SliderController(SliderValue.single(0.3));
  /// ```
  SliderController(super.value);
  /// Sets the slider to a single value configuration.
  ///
  /// Converts the slider to single-thumb mode with the specified [value].
  /// The value should be within the slider's min/max bounds.
  void setValue(double value);
  /// Sets the slider to a range value configuration.
  ///
  /// Converts the slider to dual-thumb mode with the specified [start] and [end] values.
  /// The values should be within the slider's min/max bounds with start <= end.
  void setRange(double start, double end);
  /// Returns true if the slider is in single-value mode.
  bool get isSingle;
  /// Returns true if the slider is in range mode.
  bool get isRanged;
  /// Gets the current single value (valid only in single mode).
  ///
  /// Throws an exception if called when the slider is in range mode.
  double get singleValue;
  /// Gets the current range start value (valid only in range mode).
  ///
  /// Throws an exception if called when the slider is in single mode.
  double get rangeStart;
  /// Gets the current range end value (valid only in range mode).
  ///
  /// Throws an exception if called when the slider is in single mode.
  double get rangeEnd;
}
```
