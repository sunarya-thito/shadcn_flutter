---
title: "Class: AnimatedValueBuilder"
description: "A versatile animated widget that smoothly transitions between values."
---

```dart
/// A versatile animated widget that smoothly transitions between values.
///
/// [AnimatedValueBuilder] provides three different construction modes to handle
/// various animation requirements:
/// - Default constructor: Uses a simple value-based builder
/// - [AnimatedValueBuilder.animation]: Provides direct Animation access
/// - [AnimatedValueBuilder.raw]: Gives raw interpolation control
///
/// The widget automatically handles animation lifecycle, including proper disposal
/// of resources and smooth transitions when the target value changes during animation.
/// It supports custom interpolation functions via the [lerp] parameter for complex
/// data types that don't support standard numeric interpolation.
///
/// Example:
/// ```dart
/// AnimatedValueBuilder<double>(
///   value: _targetOpacity,
///   duration: Duration(milliseconds: 300),
///   curve: Curves.easeInOut,
///   builder: (context, opacity, child) {
///     return Opacity(
///       opacity: opacity,
///       child: Text('Fading Text'),
///     );
///   },
/// );
/// ```
class AnimatedValueBuilder<T> extends StatefulWidget {
  /// The initial value to start animation from.
  ///
  /// If null, animation starts from [value] with no initial transition.
  /// When provided, the widget will animate from this value to [value] on first build.
  final T? initialValue;
  /// The target value to animate to.
  ///
  /// When this changes, the widget automatically starts a new animation from the
  /// current animated value to this new target value.
  final T value;
  /// The duration of the animation transition.
  ///
  /// This determines how long it takes to animate from the starting value to the
  /// target value. Changing this during an active animation will affect the
  /// remaining animation time.
  final Duration duration;
  /// Builder callback for value-based animation (default constructor).
  ///
  /// Called with the current interpolated value and optional child widget.
  /// Only used when constructed with the default constructor.
  final AnimatedChildBuilder<T>? builder;
  /// Builder callback for animation-based construction.
  ///
  /// Provides direct access to the underlying Animation object for advanced use cases.
  /// Only used when constructed with [AnimatedValueBuilder.animation].
  final AnimationBuilder<T>? animationBuilder;
  /// Builder callback for raw interpolation control.
  ///
  /// Called with old value, new value, interpolation progress (0.0-1.0), and child.
  /// Only used when constructed with [AnimatedValueBuilder.raw].
  final AnimatedChildValueBuilder<T>? rawBuilder;
  /// Called when the animation completes.
  ///
  /// Receives the final target value as a parameter. Useful for triggering
  /// additional actions or state changes when the animation finishes.
  final void Function(T value)? onEnd;
  /// The animation curve to use for interpolation.
  ///
  /// Controls the rate of change during animation. Defaults to [Curves.linear].
  /// Common curves include [Curves.easeInOut], [Curves.bounceIn], etc.
  final Curve curve;
  /// Custom interpolation function for complex types.
  ///
  /// Required for types that don't support standard numeric interpolation.
  /// The function receives start value [a], end value [b], and progress [t] (0.0-1.0).
  /// Must return the interpolated value at progress [t].
  final T Function(T a, T b, double t)? lerp;
  /// Optional child widget passed to the builder.
  ///
  /// Useful for optimization when part of the widget tree doesn't change
  /// during animation. The child is passed to the builder callback.
  final Widget? child;
  /// Creates an [AnimatedValueBuilder] with value-based animation.
  ///
  /// This is the standard constructor that animates between values using a simple
  /// builder callback. The builder receives the current interpolated value and
  /// can construct the appropriate widget tree.
  ///
  /// Parameters:
  /// - [initialValue] (T?, optional): Starting value for animation. If null, no initial animation occurs.
  /// - [value] (T, required): Target value to animate to.
  /// - [duration] (Duration, required): Animation duration.
  /// - [builder] (`AnimatedChildBuilder<T>`, required): Builds widget from animated value.
  /// - [onEnd] (Function?, optional): Called when animation completes.
  /// - [curve] (Curve, default: Curves.linear): Animation timing curve.
  /// - [lerp] (Function?, optional): Custom interpolation for complex types.
  /// - [child] (Widget?, optional): Optional child passed to builder.
  ///
  /// Example:
  /// ```dart
  /// AnimatedValueBuilder<double>(
  ///   initialValue: 0.0,
  ///   value: 1.0,
  ///   duration: Duration(milliseconds: 500),
  ///   curve: Curves.easeInOut,
  ///   builder: (context, opacity, child) => Opacity(
  ///     opacity: opacity,
  ///     child: Text('Hello World'),
  ///   ),
  /// );
  /// ```
  const AnimatedValueBuilder({super.key, this.initialValue, required this.value, required this.duration, required AnimatedChildBuilder<T> this.builder, this.onEnd, this.curve = Curves.linear, this.lerp, this.child});
  /// Creates an [AnimatedValueBuilder] with direct Animation access.
  ///
  /// This constructor provides the underlying [Animation] object directly to the
  /// builder, allowing for advanced animation control and multiple listeners.
  /// Useful when you need access to animation status or want to drive multiple
  /// animated properties from a single animation.
  ///
  /// Parameters:
  /// - [initialValue] (T?, optional): Starting value for animation.
  /// - [value] (T, required): Target value to animate to.
  /// - [duration] (Duration, required): Animation duration.
  /// - [builder] (`AnimationBuilder<T>`, required): Builds widget from Animation object.
  /// - [onEnd] (Function?, optional): Called when animation completes.
  /// - [curve] (Curve, default: Curves.linear): Animation timing curve.
  /// - [lerp] (Function?, optional): Custom interpolation function.
  ///
  /// Example:
  /// ```dart
  /// AnimatedValueBuilder<Color>.animation(
  ///   value: Colors.blue,
  ///   duration: Duration(seconds: 1),
  ///   builder: (context, animation) => AnimatedBuilder(
  ///     animation: animation,
  ///     builder: (context, child) => Container(
  ///       color: animation.value,
  ///       child: Text('Color transition'),
  ///     ),
  ///   ),
  /// );
  /// ```
  const AnimatedValueBuilder.animation({super.key, this.initialValue, required this.value, required this.duration, required AnimationBuilder<T> builder, this.onEnd, this.curve = Curves.linear, this.lerp});
  /// Creates an [AnimatedValueBuilder] with raw interpolation control.
  ///
  /// This constructor provides maximum control over the animation by exposing
  /// the old value, new value, and current interpolation progress. This is
  /// useful for custom transition effects or when you need to implement
  /// complex interpolation logic.
  ///
  /// Parameters:
  /// - [initialValue] (T?, optional): Starting value for animation.
  /// - [value] (T, required): Target value to animate to.
  /// - [duration] (Duration, required): Animation duration.
  /// - [builder] (`AnimatedChildValueBuilder<T>`, required): Builds widget with raw interpolation data.
  /// - [onEnd] (Function?, optional): Called when animation completes.
  /// - [curve] (Curve, default: Curves.linear): Animation timing curve.
  /// - [child] (Widget?, optional): Optional child passed to builder.
  /// - [lerp] (Function?, optional): Custom interpolation function.
  ///
  /// Example:
  /// ```dart
  /// AnimatedValueBuilder<Offset>.raw(
  ///   value: Offset(100, 100),
  ///   duration: Duration(milliseconds: 300),
  ///   builder: (context, oldPos, newPos, progress, child) {
  ///     return Transform.translate(
  ///       offset: Offset.lerp(oldPos, newPos, progress)!,
  ///       child: child,
  ///     );
  ///   },
  ///   child: Icon(Icons.star),
  /// );
  /// ```
  const AnimatedValueBuilder.raw({super.key, this.initialValue, required this.value, required this.duration, required AnimatedChildValueBuilder<T> builder, this.onEnd, this.curve = Curves.linear, this.child, this.lerp});
  State<StatefulWidget> createState();
}
```
