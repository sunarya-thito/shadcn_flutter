import 'package:flutter/widgets.dart';

/// A function type that interpolates between two values of type [T].
///
/// The function takes two nullable values [a] and [b], and a progress value [t]
/// (typically between 0 and 1), and returns the interpolated value.
///
/// ## Parameters
///
/// * [a] - The starting value. If `null`, the function may return `null`.
/// * [b] - The ending value. If `null`, the function may return `null`.
/// * [t] - The interpolation progress, typically in the range [0.0, 1.0] where
///   0.0 represents the start ([a]) and 1.0 represents the end ([b]).
///
/// ## Returns
///
/// The interpolated value between [a] and [b], or `null` if either input is `null`.
///
/// ## Example
///
/// ```dart
/// PropertyLerp<double> doubleLerp = (a, b, t) {
///   if (a == null || b == null) return null;
///   return a + (b - a) * t;
/// };
///
/// final result = doubleLerp(0.0, 100.0, 0.5); // Returns 50.0
/// ```
typedef PropertyLerp<T> = T? Function(T? a, T? b, double t);

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
  final AnimationController _controller;

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

  double _from = 0;
  double _to = 1;
  Curve _curve = Curves.linear;

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
  TickerFuture forward(double to, [Curve? curve]) {
    _from = value;
    _to = to;
    _curve = curve ?? Curves.linear;
    return _controller.forward(from: 0);
  }

  set value(double value) {
    _from = value;
    _to = value;
    _curve = Curves.linear;
    _controller.value = 0;
  }

  @override
  void addListener(VoidCallback listener) {
    _controller.addListener(listener);
  }

  @override
  void addStatusListener(AnimationStatusListener listener) {
    _controller.addStatusListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _controller.removeListener(listener);
  }

  @override
  void removeStatusListener(AnimationStatusListener listener) {
    _controller.removeStatusListener(listener);
  }

  @override
  AnimationStatus get status => _controller.status;

  @override
  double get value =>
      _from + (_to - _from) * _curve.transform(_controller.value);
}

/// Utility class providing static methods for interpolating between common types.
///
/// This class contains type-specific lerp (linear interpolation) functions that
/// handle nullable values and perform smooth transitions between values.
///
/// ## Overview
///
/// Use [Transformers] when you need to interpolate between values of common types
/// like `double`, `int`, `Color`, `Offset`, or `Size`. Each method handles `null`
/// values gracefully by returning `null` if either input is `null`.
///
/// ## Example
///
/// ```dart
/// final color = Transformers.typeColor(Colors.red, Colors.blue, 0.5);
/// final position = Transformers.typeOffset(Offset.zero, Offset(100, 100), 0.3);
/// ```
class Transformers {
  /// Linearly interpolates between two nullable [double] values.
  ///
  /// ## Parameters
  ///
  /// * [a] - The starting value. If `null`, returns `null`.
  /// * [b] - The ending value. If `null`, returns `null`.
  /// * [t] - The interpolation factor, typically in range [0.0, 1.0].
  ///
  /// ## Returns
  ///
  /// The interpolated value, or `null` if either input is `null`.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final result = Transformers.typeDouble(0.0, 100.0, 0.5); // 50.0
  /// final nullResult = Transformers.typeDouble(null, 100.0, 0.5); // null
  /// ```
  static double? typeDouble(double? a, double? b, double t) {
    if (a == null || b == null) {
      return null;
    }
    return a + (b - a) * t;
  }

  /// Linearly interpolates between two nullable [int] values.
  ///
  /// ## Parameters
  ///
  /// * [a] - The starting integer. If `null`, returns `null`.
  /// * [b] - The ending integer. If `null`, returns `null`.
  /// * [t] - The interpolation factor, typically in range [0.0, 1.0].
  ///
  /// ## Returns
  ///
  /// The interpolated value rounded to the nearest integer, or `null` if either input is `null`.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final result = Transformers.typeInt(0, 100, 0.5); // 50
  /// final result2 = Transformers.typeInt(0, 100, 0.51); // 51 (rounded)
  /// ```
  static int? typeInt(int? a, int? b, double t) {
    if (a == null || b == null) {
      return null;
    }
    return (a + (b - a) * t).round();
  }

  /// Linearly interpolates between two nullable [Color] values.
  ///
  /// ## Parameters
  ///
  /// * [a] - The starting color. If `null`, returns `null`.
  /// * [b] - The ending color. If `null`, returns `null`.
  /// * [t] - The interpolation factor, typically in range [0.0, 1.0].
  ///
  /// ## Returns
  ///
  /// The interpolated color using Flutter's `Color.lerp`, or `null` if either input is `null`.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final purple = Transformers.typeColor(Colors.red, Colors.blue, 0.5);
  /// final almostBlue = Transformers.typeColor(Colors.red, Colors.blue, 0.9);
  /// ```
  static Color? typeColor(Color? a, Color? b, double t) {
    if (a == null || b == null) {
      return null;
    }
    return Color.lerp(a, b, t);
  }

  /// Linearly interpolates between two nullable [Offset] values.
  ///
  /// ## Parameters
  ///
  /// * [a] - The starting offset. If `null`, returns `null`.
  /// * [b] - The ending offset. If `null`, returns `null`.
  /// * [t] - The interpolation factor, typically in range [0.0, 1.0].
  ///
  /// ## Returns
  ///
  /// The interpolated offset with both dx and dy components interpolated,
  /// or `null` if either input is `null`.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final offset = Transformers.typeOffset(
  ///   Offset(0, 0),
  ///   Offset(100, 50),
  ///   0.5,
  /// ); // Offset(50, 25)
  /// ```
  static Offset? typeOffset(Offset? a, Offset? b, double t) {
    if (a == null || b == null) {
      return null;
    }
    return Offset(
      typeDouble(a.dx, b.dx, t)!,
      typeDouble(a.dy, b.dy, t)!,
    );
  }

  /// Linearly interpolates between two nullable [Size] values.
  ///
  /// ## Parameters
  ///
  /// * [a] - The starting size. If `null`, returns `null`.
  /// * [b] - The ending size. If `null`, returns `null`.
  /// * [t] - The interpolation factor, typically in range [0.0, 1.0].
  ///
  /// ## Returns
  ///
  /// The interpolated size with both width and height components interpolated,
  /// or `null` if either input is `null`.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final size = Transformers.typeSize(
  ///   Size(100, 50),
  ///   Size(200, 150),
  ///   0.5,
  /// ); // Size(150, 100)
  /// ```
  static Size? typeSize(Size? a, Size? b, double t) {
    if (a == null || b == null) {
      return null;
    }
    return Size(
      typeDouble(a.width, b.width, t)!,
      typeDouble(a.height, b.height, t)!,
    );
  }
}

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
  final List<AnimatedProperty> _animatedProperties = [];

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
  AnimatedProperty<T> createAnimatedProperty<T>(T value, PropertyLerp<T> lerp) {
    final property = AnimatedProperty._(this, value, lerp, setState);
    _animatedProperties.add(property);
    return property;
  }

  @override
  void dispose() {
    for (final property in _animatedProperties) {
      property._controller.dispose();
    }
    super.dispose();
  }

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
  AnimatedProperty<int> createAnimatedInt(int value) {
    return createAnimatedProperty(value, Transformers.typeInt);
  }

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
  AnimatedProperty<double> createAnimatedDouble(double value) {
    return createAnimatedProperty(value, Transformers.typeDouble);
  }

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
  AnimatedProperty<Color> createAnimatedColor(Color value) {
    return createAnimatedProperty(value, Transformers.typeColor);
  }
}

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
  void _empty() {}
  final TickerProvider _vsync;
  final PropertyLerp<T> _lerp;
  T _value;
  bool _hasTarget = false;
  late T _target;
  late AnimationController _controller;

  AnimatedProperty._(this._vsync, this._value, this._lerp,
      Function(VoidCallback callback) update) {
    _controller = AnimationController(vsync: _vsync);
    _controller.addListener(() {
      update(_empty);
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _value = _target;
        _hasTarget = false;
      }
    });
  }

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
  T get value {
    if (_hasTarget) {
      return _lerp(_value!, _target!, _controller.value)!;
    }
    return _value;
  }

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
  set value(T value) {
    if (_hasTarget) {
      _controller.reset();
      _controller.forward();
    }
    _target = value;
  }
}

/// Represents a request to animate to a specific target value.
///
/// This class encapsulates the parameters needed for a single animation step,
/// including the target value, duration, and easing curve.
///
/// ## Overview
///
/// Use [AnimationRequest] with [AnimationQueueController] to queue multiple
/// animation steps that will be executed sequentially or as replacements.
///
/// ## Example
///
/// ```dart
/// final request = AnimationRequest(
///   1.0,
///   Duration(milliseconds: 300),
///   Curves.easeOut,
/// );
/// controller.push(request);
/// ```
class AnimationRequest {
  /// The target value to animate to (typically 0.0 to 1.0).
  final double target;

  /// The duration of the animation.
  final Duration duration;

  /// The easing curve to apply during the animation.
  final Curve curve;

  /// Creates an animation request with the specified parameters.
  ///
  /// ## Parameters
  ///
  /// * [target] - The destination value for the animation.
  /// * [duration] - How long the animation should take.
  /// * [curve] - The easing curve to use.
  AnimationRequest(this.target, this.duration, this.curve);
}

/// Manages the execution of a single animation step.
///
/// This class tracks the progress of an animation from a start value to an
/// end value over a specified duration using a curve.
///
/// ## Overview
///
/// [AnimationRunner] is used internally by [AnimationQueueController] to
/// execute individual animation steps. It tracks progress and computes
/// intermediate values.
///
/// ## Example
///
/// ```dart
/// final runner = AnimationRunner(
///   0.0, // from
///   1.0, // to
///   Duration(milliseconds: 200),
///   Curves.easeIn,
/// );
/// ```
class AnimationRunner {
  /// The starting value of the animation.
  final double from;

  /// The ending value of the animation.
  final double to;

  /// The total duration of the animation.
  final Duration duration;

  /// The easing curve applied to the animation.
  final Curve curve;

  double _progress = 0.0;

  /// Creates an animation runner with the specified parameters.
  ///
  /// ## Parameters
  ///
  /// * [from] - The starting value.
  /// * [to] - The target value.
  /// * [duration] - The animation duration.
  /// * [curve] - The easing curve.
  AnimationRunner(this.from, this.to, this.duration, this.curve);
}

/// A controller that manages a queue of animation requests.
///
/// This class extends [ChangeNotifier] and provides a way to queue multiple
/// animations that execute sequentially or replace the current queue. It
/// handles timing via [tick] calls and notifies listeners of value changes.
///
/// ## Overview
///
/// Use [AnimationQueueController] when you need to chain multiple animations
/// or dynamically add/remove animation steps. Call [tick] regularly (e.g., in
/// a ticker or animation frame callback) to progress the animations.
///
/// ## Example
///
/// ```dart
/// final controller = AnimationQueueController(0.0);
///
/// // Queue animations
/// controller.push(AnimationRequest(0.5, Duration(milliseconds: 200), Curves.easeIn));
/// controller.push(AnimationRequest(1.0, Duration(milliseconds: 300), Curves.easeOut));
///
/// // In ticker
/// controller.tick(deltaTime);
/// ```
class AnimationQueueController extends ChangeNotifier {
  double _value;

  /// Creates an animation queue controller with an optional initial value.
  ///
  /// ## Parameters
  ///
  /// * [_value] - The initial value. Defaults to `0.0`.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final controller = AnimationQueueController(0.5);
  /// ```
  AnimationQueueController([this._value = 0.0]);

  List<AnimationRequest> _requests = [];
  AnimationRunner? _runner;

  /// Adds an animation request to the queue or replaces the current queue.
  ///
  /// ## Parameters
  ///
  /// * [request] - The animation request to add.
  /// * [queue] - If `true` (default), adds to the queue. If `false`, clears
  ///   the queue and current runner, making this the only animation.
  ///
  /// ## Side Effects
  ///
  /// Notifies listeners after modifying the queue.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Add to queue
  /// controller.push(request);
  ///
  /// // Replace queue
  /// controller.push(request, false);
  /// ```
  void push(AnimationRequest request, [bool queue = true]) {
    if (queue) {
      _requests.add(request);
    } else {
      _runner = null;
      _requests = [request];
    }
    _runner ??= AnimationRunner(
        _value, request.target, request.duration, request.curve);
    notifyListeners();
  }

  /// Sets the current value immediately, clearing all queued animations.
  ///
  /// ## Parameters
  ///
  /// * [value] - The new value to set.
  ///
  /// ## Side Effects
  ///
  /// Clears the animation queue and runner, then notifies listeners.
  ///
  /// ## Example
  ///
  /// ```dart
  /// controller.value = 0.5; // Jumps to 0.5, cancels animations
  /// ```
  set value(double value) {
    _value = value;
    _runner = null;
    _requests.clear();
    notifyListeners();
  }

  /// Gets the current animation value.
  ///
  /// ## Returns
  ///
  /// The current value, which may be actively animating.
  double get value => _value;

  /// Checks if there are pending animations or an active runner.
  ///
  /// ## Returns
  ///
  /// `true` if animations should continue to be ticked, `false` otherwise.
  ///
  /// ## Example
  ///
  /// ```dart
  /// if (controller.shouldTick) {
  ///   controller.tick(deltaTime);
  /// }
  /// ```
  bool get shouldTick => _runner != null || _requests.isNotEmpty;

  /// Advances the animation by the given time delta.
  ///
  /// Call this method regularly (e.g., from a ticker) to progress animations.
  /// If the current animation completes, the next queued animation starts.
  ///
  /// ## Parameters
  ///
  /// * [delta] - The time elapsed since the last tick.
  ///
  /// ## Side Effects
  ///
  /// Updates [value] and notifies listeners as the animation progresses.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // In a ticker callback
  /// void _tick(Duration elapsed) {
  ///   final delta = elapsed - _lastElapsed;
  ///   controller.tick(delta);
  ///   _lastElapsed = elapsed;
  /// }
  /// ```
  void tick(Duration delta) {
    if (_requests.isNotEmpty) {
      final request = _requests.removeAt(0);
      _runner = AnimationRunner(
          _value, request.target, request.duration, request.curve);
    }
    final runner = _runner;
    if (runner != null) {
      runner._progress += delta.inMilliseconds / runner.duration.inMilliseconds;
      _value = runner.from +
          (runner.to - runner.from) *
              runner.curve.transform(runner._progress.clamp(0, 1));
      if (runner._progress >= 1.0) {
        _runner = null;
      }
      notifyListeners();
    }
  }
}

/// An abstract interface for keyframes in timeline animations.
///
/// A keyframe defines how to compute a value at a specific point in a
/// timeline animation. Different implementations provide different interpolation
/// strategies (absolute, relative, or static).
///
/// ## Type Parameters
///
/// * [T] - The type of value this keyframe produces.
///
/// ## Overview
///
/// Use [Keyframe] implementations like [AbsoluteKeyframe], [RelativeKeyframe],
/// or [StillKeyframe] to build complex timeline animations with
/// [TimelineAnimation].
///
/// See also:
///
/// * [AbsoluteKeyframe] - Animates between explicit start and end values.
/// * [RelativeKeyframe] - Animates from the previous keyframe's end value.
/// * [StillKeyframe] - Holds a value without animating.
abstract class Keyframe<T> {
  /// The duration of this keyframe.
  ///
  /// ## Returns
  ///
  /// The time this keyframe takes to complete.
  Duration get duration;

  /// Computes the value for this keyframe at the given progress.
  ///
  /// ## Parameters
  ///
  /// * [timeline] - The parent timeline animation.
  /// * [index] - The index of this keyframe in the timeline.
  /// * [t] - The local progress through this keyframe (0.0 to 1.0).
  ///
  /// ## Returns
  ///
  /// The computed value of type [T] at the given progress.
  T compute(TimelineAnimation<T> timeline, int index, double t);
}

/// A keyframe that animates between explicit start and end values.
///
/// This keyframe interpolates from a specified [from] value to a [to] value
/// over its [duration], independent of previous keyframes.
///
/// ## Type Parameters
///
/// * [T] - The type of value to animate.
///
/// ## Overview
///
/// Use [AbsoluteKeyframe] when you want complete control over both the start
/// and end values of a keyframe, regardless of previous animation state.
///
/// ## Example
///
/// ```dart
/// // Animate from 0.0 to 1.0 over 200ms
/// final keyframe = AbsoluteKeyframe<double>(
///   Duration(milliseconds: 200),
///   0.0,
///   1.0,
/// );
/// ```
class AbsoluteKeyframe<T> implements Keyframe<T> {
  /// The starting value of the animation.
  final T from;

  /// The ending value of the animation.
  final T to;

  @override
  final Duration duration;

  /// Creates an absolute keyframe with explicit start and end values.
  ///
  /// ## Parameters
  ///
  /// * [duration] - How long to animate from [from] to [to].
  /// * [from] - The starting value.
  /// * [to] - The ending value.
  const AbsoluteKeyframe(
    this.duration,
    this.from,
    this.to,
  );

  @override
  T compute(TimelineAnimation<T> timeline, int index, double t) {
    return timeline.lerp(from!, to!, t)!;
  }
}

/// A keyframe that animates from the previous keyframe's end value to a target.
///
/// This keyframe automatically uses the ending value of the previous keyframe
/// as its starting point, animating to the specified [target] value.
///
/// ## Type Parameters
///
/// * [T] - The type of value to animate.
///
/// ## Overview
///
/// Use [RelativeKeyframe] for smooth transitions between keyframes without
/// explicitly specifying start values. If used as the first keyframe, it acts
/// as a still keyframe.
///
/// ## Example
///
/// ```dart
/// final timeline = TimelineAnimation<double>(
///   keyframes: [
///     AbsoluteKeyframe(Duration(milliseconds: 100), 0.0, 0.5),
///     RelativeKeyframe(Duration(milliseconds: 100), 1.0), // from 0.5 to 1.0
///   ],
/// );
/// ```
class RelativeKeyframe<T> implements Keyframe<T> {
  /// The target value to animate to from the previous keyframe's end.
  final T target;

  @override
  final Duration duration;

  /// Creates a relative keyframe that animates to the target value.
  ///
  /// ## Parameters
  ///
  /// * [duration] - How long to animate to [target].
  /// * [target] - The ending value for this keyframe.
  const RelativeKeyframe(
    this.duration,
    this.target,
  );

  @override
  T compute(TimelineAnimation<T> timeline, int index, double t) {
    if (index <= 0) {
      // act as still keyframe when there is no previous keyframe
      return target;
    }
    final previous =
        timeline.keyframes[index - 1].compute(timeline, index - 1, 1.0);
    return timeline.lerp(previous!, target!, t)!;
  }
}

/// A keyframe that holds a constant value without animating.
///
/// This keyframe maintains a static value for its duration. If [value] is `null`,
/// it uses the ending value from the previous keyframe.
///
/// ## Type Parameters
///
/// * [T] - The type of value to hold.
///
/// ## Overview
///
/// Use [StillKeyframe] to create pauses or delays in timeline animations where
/// the value remains constant for a period of time.
///
/// ## Example
///
/// ```dart
/// final timeline = TimelineAnimation<double>(
///   keyframes: [
///     AbsoluteKeyframe(Duration(milliseconds: 100), 0.0, 1.0),
///     StillKeyframe(Duration(milliseconds: 200)), // Hold at 1.0 for 200ms
///     RelativeKeyframe(Duration(milliseconds: 100), 0.0), // Back to 0.0
///   ],
/// );
/// ```
class StillKeyframe<T> implements Keyframe<T> {
  /// The value to hold, or `null` to use the previous keyframe's end value.
  final T? value;

  @override
  final Duration duration;

  /// Creates a still keyframe that holds a value.
  ///
  /// ## Parameters
  ///
  /// * [duration] - How long to hold the value.
  /// * [value] - The value to hold, or `null` to use the previous keyframe's end value.
  ///
  /// ## Notes
  ///
  /// If [value] is `null`, this keyframe must not be the first in the timeline.
  const StillKeyframe(this.duration, [this.value]);

  @override
  T compute(TimelineAnimation<T> timeline, int index, double t) {
    var value = this.value;
    if (value == null) {
      assert(
          index > 0, 'Relative still keyframe must have a previous keyframe');
      value = timeline.keyframes[index - 1].compute(timeline, index - 1, 1.0);
    }
    return value as T;
  }
}

/// An [Animatable] wrapper for [TimelineAnimation] with explicit duration.
///
/// This class adapts a [TimelineAnimation] to work with a specific total duration,
/// scaling the animation to fit within that time frame.
///
/// ## Type Parameters
///
/// * [T] - The type of value being animated.
///
/// ## Overview
///
/// [TimelineAnimatable] is typically created via [TimelineAnimation.drive] or
/// [TimelineAnimation.withTotalDuration] to bind a timeline to a controller.
///
/// ## Example
///
/// ```dart
/// final controller = AnimationController(
///   vsync: this,
///   duration: Duration(seconds: 2),
/// );
/// final animatable = timeline.drive(controller);
/// ```
class TimelineAnimatable<T> extends Animatable<T> {
  /// The total duration for this animatable.
  final Duration duration;

  /// The underlying timeline animation.
  final TimelineAnimation<T> animation;

  /// Creates a timeline animatable with the specified duration.
  ///
  /// ## Parameters
  ///
  /// * [duration] - The total duration for the animation.
  /// * [animation] - The timeline animation to wrap.
  TimelineAnimatable(this.duration, this.animation);

  @override
  T transform(double t) {
    Duration selfDuration = animation.totalDuration;
    double selfT = (t * selfDuration.inMilliseconds) / duration.inMilliseconds;
    return animation.transform(selfT);
  }
}

/// A timeline-based animation built from multiple keyframes.
///
/// This class extends [Animatable]`<T>` and orchestrates complex animations by
/// sequencing multiple [Keyframe]s. Each keyframe defines a segment of the
/// animation with its own duration and interpolation strategy.
///
/// ## Type Parameters
///
/// * [T] - The type of value being animated.
///
/// ## Overview
///
/// Use [TimelineAnimation] to create sophisticated multi-stage animations.
/// Keyframes can be absolute, relative, or still, allowing for diverse
/// animation patterns. The timeline automatically calculates total duration
/// from all keyframes.
///
/// ## Example
///
/// ```dart
/// final timeline = TimelineAnimation<double>(
///   lerp: Transformers.typeDouble,
///   keyframes: [
///     AbsoluteKeyframe(Duration(milliseconds: 100), 0.0, 1.0),
///     StillKeyframe(Duration(milliseconds: 50)),
///     RelativeKeyframe(Duration(milliseconds: 100), 0.5),
///   ],
/// );
/// ```
class TimelineAnimation<T> extends Animatable<T> {
  /// Default lerp function that works with numeric types.
  ///
  /// This function performs basic arithmetic interpolation. It assumes the
  /// type supports addition, subtraction, and multiplication operators.
  ///
  /// ## Type Parameters
  ///
  /// * [T] - The type to interpolate (must support arithmetic operations).
  ///
  /// ## Parameters
  ///
  /// * [a] - The starting value.
  /// * [b] - The ending value.
  /// * [t] - The interpolation factor (0.0 to 1.0).
  ///
  /// ## Returns
  ///
  /// The interpolated value.
  static T defaultLerp<T>(T a, T b, double t) {
    return ((a as dynamic) + ((b as dynamic) - (a as dynamic)) * t) as T;
  }

  /// The interpolation function used for this timeline.
  final PropertyLerp<T> lerp;

  /// The total duration of all keyframes combined.
  final Duration totalDuration;

  /// The list of keyframes that make up this timeline.
  final List<Keyframe<T>> keyframes;

  TimelineAnimation._({
    required this.lerp,
    required this.totalDuration,
    required this.keyframes,
  });

  /// Creates a timeline animation from a list of keyframes.
  ///
  /// ## Parameters
  ///
  /// * [lerp] - Optional interpolation function. Uses [defaultLerp] if not provided.
  /// * [keyframes] - The list of keyframes defining the animation. Must not be empty.
  ///
  /// ## Returns
  ///
  /// A new [TimelineAnimation] with calculated total duration.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final timeline = TimelineAnimation<Color>(
  ///   lerp: Transformers.typeColor,
  ///   keyframes: [
  ///     AbsoluteKeyframe(Duration(milliseconds: 300), Colors.red, Colors.blue),
  ///     RelativeKeyframe(Duration(milliseconds: 200), Colors.green),
  ///   ],
  /// );
  /// ```
  factory TimelineAnimation({
    PropertyLerp<T>? lerp,
    required List<Keyframe<T>> keyframes,
  }) {
    lerp ??= defaultLerp;
    assert(keyframes.isNotEmpty, 'No keyframes found');
    Duration current = Duration.zero;
    for (var i = 0; i < keyframes.length; i++) {
      final keyframe = keyframes[i];
      assert(keyframe.duration.inMilliseconds > 0, 'Invalid duration');
      current += keyframe.duration;
    }
    return TimelineAnimation._(
      lerp: lerp,
      totalDuration: current,
      keyframes: keyframes,
    );
  }

  Duration _computeDuration(double t) {
    final totalDuration = this.totalDuration;
    return Duration(milliseconds: (t * totalDuration.inMilliseconds).floor());
  }

  /// Binds this timeline to an [AnimationController].
  ///
  /// ## Parameters
  ///
  /// * [controller] - The animation controller to drive this timeline.
  ///   Must have a non-null duration.
  ///
  /// ## Returns
  ///
  /// A [TimelineAnimatable] that can be used with the controller.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final controller = AnimationController(
  ///   vsync: this,
  ///   duration: Duration(seconds: 1),
  /// );
  /// final animatable = timeline.drive(controller);
  /// ```
  TimelineAnimatable<T> drive(AnimationController controller) {
    return TimelineAnimatable(controller.duration!, this);
  }

  /// Transforms the timeline using the controller's current value.
  ///
  /// This is a convenience method that combines [drive] and [Animatable.transform].
  ///
  /// ## Parameters
  ///
  /// * [controller] - The animation controller to read the value from.
  ///
  /// ## Returns
  ///
  /// The current value of type [T] based on the controller's progress.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final value = timeline.transformWithController(controller);
  /// ```
  T transformWithController(AnimationController controller) {
    return drive(controller).transform(controller.value);
  }

  /// Creates a [TimelineAnimatable] with the specified total duration.
  ///
  /// ## Parameters
  ///
  /// * [duration] - The desired total duration for this timeline.
  ///
  /// ## Returns
  ///
  /// A [TimelineAnimatable] that scales this timeline to the given duration.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Timeline with natural duration of 500ms
  /// final timeline = TimelineAnimation<double>(...);
  ///
  /// // Scale to 2 seconds
  /// final animatable = timeline.withTotalDuration(Duration(seconds: 2));
  /// ```
  TimelineAnimatable<T> withTotalDuration(Duration duration) {
    return TimelineAnimatable(duration, this);
  }

  @override
  T transform(double t) {
    assert(t >= 0 && t <= 1, 'Invalid time $t');
    assert(keyframes.isNotEmpty, 'No keyframes found');
    var duration = _computeDuration(t);
    var current = Duration.zero;
    for (var i = 0; i < keyframes.length; i++) {
      final keyframe = keyframes[i];
      final next = current + keyframe.duration;
      if (duration < next) {
        final localT = (duration - current).inMilliseconds /
            keyframe.duration.inMilliseconds;
        return keyframe.compute(this, i, localT);
      }
      current = next;
    }
    return keyframes.last.compute(this, keyframes.length - 1, 1.0);
  }
}

/// Returns the maximum of two [Duration] values.
///
/// ## Parameters
///
/// * [a] - The first duration.
/// * [b] - The second duration.
///
/// ## Returns
///
/// The longer of the two durations.
///
/// ## Example
///
/// ```dart
/// final longer = maxDuration(
///   Duration(milliseconds: 100),
///   Duration(milliseconds: 200),
/// ); // Duration(milliseconds: 200)
/// ```
Duration maxDuration(Duration a, Duration b) {
  return a > b ? a : b;
}

/// Returns the minimum of two [Duration] values.
///
/// ## Parameters
///
/// * [a] - The first duration.
/// * [b] - The second duration.
///
/// ## Returns
///
/// The shorter of the two durations.
///
/// ## Example
///
/// ```dart
/// final shorter = minDuration(
///   Duration(milliseconds: 100),
///   Duration(milliseconds: 200),
/// ); // Duration(milliseconds: 100)
/// ```
Duration minDuration(Duration a, Duration b) {
  return a < b ? a : b;
}

/// Finds the maximum total duration among multiple timeline animations.
///
/// ## Parameters
///
/// * [timelines] - An iterable collection of [TimelineAnimation] instances.
///
/// ## Returns
///
/// The longest [totalDuration] found among all timelines, or [Duration.zero]
/// if the collection is empty.
///
/// ## Example
///
/// ```dart
/// final timelines = [
///   TimelineAnimation<double>(keyframes: [...]), // 300ms
///   TimelineAnimation<Color>(keyframes: [...]),   // 500ms
///   TimelineAnimation<Offset>(keyframes: [...]),  // 200ms
/// ];
///
/// final maxDur = timelineMaxDuration(timelines); // Duration(milliseconds: 500)
/// ```
Duration timelineMaxDuration(Iterable<TimelineAnimation> timelines) {
  Duration max = Duration.zero;
  for (final timeline in timelines) {
    max = maxDuration(max, timeline.totalDuration);
  }
  return max;
}
