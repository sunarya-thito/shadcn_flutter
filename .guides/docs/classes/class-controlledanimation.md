---
title: "Class: ControlledAnimation"
description: "A controlled animation that wraps an [AnimationController] and provides  smooth transitions between values using curves.   This class extends [Animation]`<double>` and allows programmatic control  of animations with custom start and end values, as well as curve adjustments.   ## Overview   Use [ControlledAnimation] when you need fine-grained control over animation  values and want to smoothly transition from any current value to a target  value with a specified curve.   ## Example   ```dart  final controller = AnimationController(    vsync: this,    duration: const Duration(milliseconds: 300),  );  final animation = ControlledAnimation(controller);   // Animate to 0.8 with ease-in curve  animation.forward(0.8, Curves.easeIn);  ```"
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
  /// Sets [value] without touching the underlying [AnimationController] —
  /// unlike the [value] setter, this never calls `notifyListeners()`.
  ///
  /// Use this only to seed the *initial* resting value before anything has
  /// had a chance to listen (e.g. before a dependent `AnimatedBuilder` has
  /// built for the first time). Calling the regular [value] setter once a
  /// listener is already attached mid-frame trips Flutter's "Build
  /// scheduled during frame" guard, since it requests a rebuild for
  /// something already being processed this frame; [seed] sidesteps that
  /// because it notifies no one, which also means it should not be used to
  /// report an actual, listener-visible change — only to establish a
  /// starting value nothing has read yet.
  void seed(double value);
  void addListener(VoidCallback listener);
  void addStatusListener(AnimationStatusListener listener);
  void removeListener(VoidCallback listener);
  void removeStatusListener(AnimationStatusListener listener);
  AnimationStatus get status;
  double get value;
}
```
