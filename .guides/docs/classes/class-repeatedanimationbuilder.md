---
title: "Class: RepeatedAnimationBuilder"
description: "An animated widget that continuously repeats an animation between two values."
---

```dart
/// An animated widget that continuously repeats an animation between two values.
///
/// [RepeatedAnimationBuilder] provides automatic looping animations with various
/// repeat modes including forward-only, reverse-only, and ping-pong patterns.
/// Unlike [AnimatedValueBuilder], this widget is designed for continuous motion
/// and doesn't stop at a target value.
///
/// The widget supports different repeat modes via [RepeatMode]:
/// - [RepeatMode.repeat]: Continuous forward animation with instant reset
/// - [RepeatMode.reverse]: Continuous reverse animation
/// - [RepeatMode.pingPong]: Smooth back-and-forth animation
/// - [RepeatMode.pingPongReverse]: Ping-pong starting in reverse
///
/// Animation can be paused and resumed using the [play] parameter, and supports
/// different durations for forward and reverse directions when using ping-pong modes.
///
/// Example:
/// ```dart
/// RepeatedAnimationBuilder<double>(
///   start: 0.0,
///   end: 1.0,
///   duration: Duration(seconds: 2),
///   mode: RepeatMode.pingPong,
///   builder: (context, value, child) {
///     return Opacity(
///       opacity: value,
///       child: Icon(Icons.favorite, size: 50),
///     );
///   },
/// );
/// ```
class RepeatedAnimationBuilder<T> extends StatefulWidget {
  /// The starting value for the animation.
  ///
  /// This is the value the animation begins with in forward mode or ends with
  /// in reverse mode. For ping-pong modes, this represents one extreme of the oscillation.
  final T start;
  /// The ending value for the animation.
  ///
  /// This is the value the animation reaches in forward mode or starts from
  /// in reverse mode. For ping-pong modes, this represents the other extreme of the oscillation.
  final T end;
  /// The duration for the primary animation direction.
  ///
  /// For forward and reverse modes, this is the complete cycle duration.
  /// For ping-pong modes, this is the duration of the forward portion of each cycle.
  final Duration duration;
  /// The duration for the reverse direction in ping-pong modes.
  ///
  /// If null, uses [duration] for both directions. Only affects ping-pong modes
  /// where you want asymmetric timing between forward and reverse motions.
  final Duration? reverseDuration;
  /// The easing curve for the primary animation direction.
  ///
  /// Controls how the animation progresses over time. Defaults to [Curves.linear].
  final Curve curve;
  /// The easing curve for the reverse direction in ping-pong modes.
  ///
  /// If null, uses [curve] for both directions. Allows different easing
  /// for forward and reverse portions of ping-pong animations.
  final Curve? reverseCurve;
  /// The repeat mode determining animation behavior.
  ///
  /// Controls whether animation repeats forward, reverse, or alternates directions.
  /// See [RepeatMode] for available options. Defaults to [RepeatMode.repeat].
  final RepeatMode mode;
  /// Builder callback for value-based repeated animation.
  ///
  /// Called with the current animated value and optional child widget.
  /// Used with the default constructor for standard value-based building.
  final Widget Function(BuildContext context, T value, Widget? child)? builder;
  /// Builder callback for animation-based construction.
  ///
  /// Provides direct access to the underlying Animation object for advanced control.
  /// Used with [RepeatedAnimationBuilder.animation] constructor.
  final Widget Function(BuildContext context, Animation<T> animation)? animationBuilder;
  /// Optional child widget passed to the builder.
  ///
  /// Useful for optimization when part of the widget tree remains constant
  /// during animation. The child is passed through to the builder callback.
  final Widget? child;
  /// Custom interpolation function for complex data types.
  ///
  /// Required for types that don't support standard numeric interpolation.
  /// Receives start value [a], end value [b], and progress [t] (0.0-1.0).
  final T Function(T a, T b, double t)? lerp;
  /// Whether the animation should be playing.
  ///
  /// When true, the animation runs continuously according to [mode].
  /// When false, the animation pauses at its current position. Defaults to true.
  final bool play;
  /// Creates a [RepeatedAnimationBuilder] with value-based animation.
  ///
  /// This constructor provides a simple builder that receives the current animated
  /// value. The animation repeats continuously according to the specified [mode]
  /// and can be paused/resumed with the [play] parameter.
  ///
  /// Parameters:
  /// - [start] (T, required): Starting value of the animation range.
  /// - [end] (T, required): Ending value of the animation range.
  /// - [duration] (Duration, required): Duration for primary animation direction.
  /// - [curve] (Curve, default: Curves.linear): Easing curve for animation.
  /// - [reverseCurve] (Curve?, optional): Curve for reverse direction in ping-pong modes.
  /// - [mode] (RepeatMode, default: RepeatMode.repeat): Animation repeat behavior.
  /// - [builder] (Function, required): Builds widget from animated value.
  /// - [child] (Widget?, optional): Optional child passed to builder.
  /// - [lerp] (Function?, optional): Custom interpolation for complex types.
  /// - [play] (bool, default: true): Whether animation should be playing.
  /// - [reverseDuration] (Duration?, optional): Duration for reverse direction.
  ///
  /// Example:
  /// ```dart
  /// RepeatedAnimationBuilder<double>(
  ///   start: 0.5,
  ///   end: 1.5,
  ///   duration: Duration(seconds: 1),
  ///   mode: RepeatMode.pingPong,
  ///   curve: Curves.easeInOut,
  ///   builder: (context, scale, child) => Transform.scale(
  ///     scale: scale,
  ///     child: Icon(Icons.heart, color: Colors.red),
  ///   ),
  /// );
  /// ```
  const RepeatedAnimationBuilder({super.key, required this.start, required this.end, required this.duration, this.curve = Curves.linear, this.reverseCurve, this.mode = RepeatMode.repeat, required this.builder, this.child, this.lerp, this.play = true, this.reverseDuration});
  /// Creates a [RepeatedAnimationBuilder] with direct Animation access.
  ///
  /// This constructor provides the underlying [Animation] object directly,
  /// allowing for advanced animation control and the ability to drive multiple
  /// animated properties from a single repeated animation.
  ///
  /// Parameters:
  /// - [start] (T, required): Starting value of the animation range.
  /// - [end] (T, required): Ending value of the animation range.
  /// - [duration] (Duration, required): Duration for primary animation direction.
  /// - [curve] (Curve, default: Curves.linear): Easing curve for animation.
  /// - [reverseCurve] (Curve?, optional): Curve for reverse direction in ping-pong modes.
  /// - [mode] (RepeatMode, default: RepeatMode.repeat): Animation repeat behavior.
  /// - [animationBuilder] (Function, required): Builds widget from Animation object.
  /// - [child] (Widget?, optional): Optional child passed to builder.
  /// - [lerp] (Function?, optional): Custom interpolation for complex types.
  /// - [play] (bool, default: true): Whether animation should be playing.
  /// - [reverseDuration] (Duration?, optional): Duration for reverse direction.
  ///
  /// Example:
  /// ```dart
  /// RepeatedAnimationBuilder<Color>.animation(
  ///   start: Colors.red,
  ///   end: Colors.blue,
  ///   duration: Duration(seconds: 3),
  ///   mode: RepeatMode.pingPong,
  ///   animationBuilder: (context, animation) => Container(
  ///     width: 100,
  ///     height: 100,
  ///     decoration: BoxDecoration(
  ///       color: animation.value,
  ///       borderRadius: BorderRadius.circular(8),
  ///     ),
  ///   ),
  /// );
  /// ```
  const RepeatedAnimationBuilder.animation({super.key, required this.start, required this.end, required this.duration, this.curve = Curves.linear, this.reverseCurve, this.mode = RepeatMode.repeat, required this.animationBuilder, this.child, this.lerp, this.play = true, this.reverseDuration});
  State<RepeatedAnimationBuilder<T>> createState();
}
```
