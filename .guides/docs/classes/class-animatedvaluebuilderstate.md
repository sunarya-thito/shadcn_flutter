---
title: "Class: AnimatedValueBuilderState"
description: "State class for [AnimatedValueBuilder] that manages the animation lifecycle."
---

```dart
/// State class for [AnimatedValueBuilder] that manages the animation lifecycle.
///
/// This state class handles:
/// - Creating and disposing animation controllers
/// - Managing curved animations
/// - Driving value interpolation
/// - Responding to value changes and rebuilding accordingly
///
/// ## Type Parameters
///
/// * [T] - The type of value being animated.
///
/// ## Overview
///
/// You typically don't interact with this class directly. It's created automatically
/// by the [AnimatedValueBuilder] widget and manages all animation details internally.
class AnimatedValueBuilderState<T> extends State<AnimatedValueBuilder<T>> with SingleTickerProviderStateMixin {
  void initState();
  /// Interpolates between two values using the widget's lerp function or default.
  ///
  /// ## Parameters
  ///
  /// * [a] - The starting value.
  /// * [b] - The ending value.
  /// * [t] - The interpolation factor (0.0 to 1.0).
  ///
  /// ## Returns
  ///
  /// The interpolated value of type [T].
  ///
  /// ## Notes
  ///
  /// If [widget.lerp] is provided, it's used for interpolation. Otherwise, the
  /// method attempts dynamic arithmetic interpolation. If the type doesn't support
  /// arithmetic operations, an exception is thrown with helpful guidance.
  T lerpedValue(T a, T b, double t);
  void didUpdateWidget(AnimatedValueBuilder<T> oldWidget);
  void dispose();
  Widget build(BuildContext context);
}
```
