---
title: "Class: AnimatedProperty"
description: "A property that can be animated between values of type [T]."
---

```dart
/// A property that can be animated between values of type [T].
///
/// This class manages an animation controller and interpolates between values
/// using a custom lerp function. It automatically triggers widget rebuilds when
/// the animation progresses.
///
/// ## Type Parameters
///
/// * [T] - The type of value being animated.
///
/// ## Overview
///
/// [AnimatedProperty] is typically created via [AnimatedMixin] factory methods
/// like [createAnimatedDouble] or [createAnimatedColor]. When you set a new
/// [value], it smoothly animates from the current value to the target.
///
/// ## Example
///
/// ```dart
/// // Created via AnimatedMixin
/// final opacity = createAnimatedDouble(1.0);
///
/// // Setting value triggers animation
/// opacity.value = 0.0;
///
/// // Access current value during animation
/// final current = opacity.value;
/// ```
class AnimatedProperty<T> {
  /// Gets the current value of the animated property.
  ///
  /// If an animation is in progress (has a target), this returns the interpolated
  /// value between the start and target based on the controller's progress.
  /// Otherwise, it returns the static value.
  ///
  /// ## Returns
  ///
  /// The current value of type [T], interpolated if animating.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final opacity = createAnimatedDouble(1.0);
  /// print(opacity.value); // 1.0
  ///
  /// opacity.value = 0.0; // Start animating
  /// print(opacity.value); // Something between 0.0 and 1.0 during animation
  /// ```
  T get value;
  /// Sets a new target value and starts animating towards it.
  ///
  /// When set, this property will smoothly animate from its current value to
  /// the new target value. If already animating, the animation is reset and
  /// restarted from the current interpolated position.
  ///
  /// ## Parameters
  ///
  /// * [value] - The new target value of type [T].
  ///
  /// ## Side Effects
  ///
  /// Triggers the animation controller to start/restart, which will cause
  /// widget rebuilds via the update callback.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final size = createAnimatedDouble(100.0);
  ///
  /// // Start animation to 200.0
  /// size.value = 200.0;
  ///
  /// // Change target mid-animation
  /// size.value = 150.0; // Will animate from current position to 150.0
  /// ```
  set value(T value);
}
```
