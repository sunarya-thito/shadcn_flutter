---
title: "Class: ControlledAnimation"
description: "A controlled animation that wraps an [AnimationController] and provides  smooth transitions between values using curves."
---

```dart
/// A controlled animation that wraps an [AnimationController] and provides
/// smooth transitions between values using curves.
///
/// This class extends [Animation]`<double>` and allows programmatic control
/// of animations with custom start and end values, as well as curve adjustments.
///
/// ## Overview
///
/// Use [ControlledAnimation] when you need fine-grained control over animation
/// values and want to smoothly transition from any current value to a target
/// value with a specified curve.
///
/// ## Example
///
/// ```dart
/// final controller = AnimationController(
///   vsync: this,
///   duration: const Duration(milliseconds: 300),
/// );
/// final animation = ControlledAnimation(controller);
/// 
/// // Animate to 0.8 with ease-in curve
/// animation.forward(0.8, Curves.easeIn);
/// ```
class ControlledAnimation extends Animation<double> {
  /// Creates a [ControlledAnimation] that wraps the given [AnimationController].
  ///
  /// ## Parameters
  ///
  /// * [_controller] - The underlying animation controller to use for timing.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final controller = AnimationController(
  ///   vsync: this,
  ///   duration: const Duration(milliseconds: 200),
  /// );
  /// final animation = ControlledAnimation(controller);
  /// ```
  ControlledAnimation(this._controller);
  /// Animates from the current value to the specified target value.
  ///
  /// This method starts a forward animation from the current [value] to the
  /// specified [to] value, applying the given [curve] for easing.
  ///
  /// ## Parameters
  ///
  /// * [to] - The target value to animate to (typically between 0.0 and 1.0).
  /// * [curve] - Optional easing curve. Defaults to `Curves.linear` if not specified.
  ///
  /// ## Returns
  ///
  /// A [TickerFuture] that completes when the animation finishes.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Animate to 1.0 with ease-out curve
  /// await animation.forward(1.0, Curves.easeOut);
  /// ```
  TickerFuture forward(double to, [Curve? curve]);
  set value(double value);
  void addListener(VoidCallback listener);
  void addStatusListener(AnimationStatusListener listener);
  void removeListener(VoidCallback listener);
  void removeStatusListener(AnimationStatusListener listener);
  AnimationStatus get status;
  double get value;
}
```
