---
title: "Mixin: AnimatedMixin"
description: "A mixin that provides animated property management for stateful widgets."
---

```dart
/// A mixin that provides animated property management for stateful widgets.
///
/// This mixin extends [TickerProviderStateMixin] and manages a collection of
/// animated properties, automatically disposing of their controllers.
///
/// ## Overview
///
/// Use [AnimatedMixin] when building stateful widgets that need multiple
/// animated properties. The mixin handles lifecycle management and provides
/// convenient factory methods for common types.
///
/// ## Example
///
/// ```dart
/// class MyWidget extends StatefulWidget {
///   @override
///   State<MyWidget> createState() => _MyWidgetState();
/// }
///
/// class _MyWidgetState extends State<MyWidget>
///     with TickerProviderStateMixin, AnimatedMixin {
///   late final AnimatedProperty<double> opacity;
///
///   @override
///   void initState() {
///     super.initState();
///     opacity = createAnimatedDouble(1.0);
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return Opacity(
///       opacity: opacity.value,
///       child: Container(),
///     );
///   }
/// }
/// ```
mixin AnimatedMixin on TickerProviderStateMixin {
  /// Creates a new animated property with a custom interpolation function.
  ///
  /// ## Type Parameters
  ///
  /// * [T] - The type of value to animate.
  ///
  /// ## Parameters
  ///
  /// * [value] - The initial value of the property.
  /// * [lerp] - The interpolation function to use for animating between values.
  ///
  /// ## Returns
  ///
  /// A new [AnimatedProperty]`<T>` that will be automatically disposed.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final customProp = createAnimatedProperty<MyType>(
  ///   initialValue,
  ///   (a, b, t) => MyType.lerp(a, b, t),
  /// );
  /// ```
  AnimatedProperty<T> createAnimatedProperty<T>(T value, PropertyLerp<T> lerp);
  void dispose();
  /// Creates an animated property for integer values.
  ///
  /// This is a convenience method that uses [Transformers.typeInt] for interpolation.
  ///
  /// ## Parameters
  ///
  /// * [value] - The initial integer value.
  ///
  /// ## Returns
  ///
  /// A new [AnimatedProperty]`<int>` configured for integer interpolation.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final count = createAnimatedInt(0);
  /// count.value = 100; // Will animate from 0 to 100
  /// ```
  AnimatedProperty<int> createAnimatedInt(int value);
  /// Creates an animated property for double values.
  ///
  /// This is a convenience method that uses [Transformers.typeDouble] for interpolation.
  ///
  /// ## Parameters
  ///
  /// * [value] - The initial double value.
  ///
  /// ## Returns
  ///
  /// A new [AnimatedProperty]`<double>` configured for double interpolation.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final opacity = createAnimatedDouble(1.0);
  /// opacity.value = 0.0; // Will animate from 1.0 to 0.0
  /// ```
  AnimatedProperty<double> createAnimatedDouble(double value);
  /// Creates an animated property for [Color] values.
  ///
  /// This is a convenience method that uses [Transformers.typeColor] for interpolation.
  ///
  /// ## Parameters
  ///
  /// * [value] - The initial color value.
  ///
  /// ## Returns
  ///
  /// A new [AnimatedProperty]`<Color>` configured for color interpolation.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final bgColor = createAnimatedColor(Colors.red);
  /// bgColor.value = Colors.blue; // Will smoothly transition from red to blue
  /// ```
  AnimatedProperty<Color> createAnimatedColor(Color value);
}
```
