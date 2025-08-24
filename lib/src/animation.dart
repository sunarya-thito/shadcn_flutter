import 'package:flutter/widgets.dart';

/// A function type for interpolating between two property values.
///
/// Used by animation systems to calculate intermediate values during transitions.
/// Takes two nullable values and an interpolation factor, returning the
/// interpolated result or null if interpolation is not possible.
///
/// Example:
/// ```dart
/// final colorLerp = PropertyLerp<Color>((a, b, t) => Color.lerp(a, b, t));
/// ```
typedef PropertyLerp<T> = T? Function(T? a, T? b, double t);

/// An animation that provides fine-grained control over animation progression.
///
/// Unlike standard Flutter animations, ControlledAnimation allows you to animate
/// between arbitrary start and end values with custom curves, making it ideal
/// for complex animation sequences or when you need to chain multiple animations
/// with different parameters.
///
/// The animation maintains internal from/to values and applies the specified
/// curve to interpolate between them based on the underlying controller's progress.
///
/// Example:
/// ```dart
/// final controller = AnimationController(vsync: this);
/// final animation = ControlledAnimation(controller);
/// animation.forward(0.8, Curves.easeOut); // Animate from current to 0.8
/// ```
class ControlledAnimation extends Animation<double> {
  /// The underlying animation controller.
  final AnimationController _controller;

  /// Creates a [ControlledAnimation] wrapping the provided controller.
  ///
  /// Parameters:
  /// - [_controller] (AnimationController): The controller to wrap.
  ControlledAnimation(this._controller);

  double _from = 0;
  double _to = 1;
  Curve _curve = Curves.linear;

  /// Animates forward from the current value to the specified target value.
  ///
  /// Sets up the animation parameters and starts the forward animation.
  /// The animation will interpolate from the current value to [to] using
  /// the specified curve.
  ///
  /// Parameters:
  /// - [to] (double): The target value to animate to.
  /// - [curve] (Curve?, optional): The animation curve to use.
  ///
  /// Returns:
  /// A `TickerFuture` that completes when the animation finishes.
  ///
  /// Example:
  /// ```dart
  /// animation.forward(1.0, Curves.easeInOut);
  /// ```
  TickerFuture forward(double to, [Curve? curve]) {
    _from = value;
    _to = to;
    _curve = curve ?? Curves.linear;
    return _controller.forward(from: 0);
  }

  /// Sets the animation value directly without animating.
  ///
  /// Immediately sets the animation to the specified value and resets
  /// the controller. Useful for initializing or jumping to specific states.
  ///
  /// Parameters:
  /// - [value] (double): The value to set.
  ///
  /// Example:
  /// ```dart
  /// animation.value = 0.5; // Jump to 50%
  /// ```
  set value(double value) {
    _from = value;
    _to = value;
    _curve = Curves.linear;
    _controller.value = 0;
  }

  @override
  /// Registers a listener to be called whenever the animation value changes.
  /// 
  /// The listener will be called with the current animation progress.
  /// This is useful for updating UI elements that depend on the animation state.
  void addListener(VoidCallback listener) {
    _controller.addListener(listener);
  }

  @override
  /// Registers a status listener to be called when animation status changes.
  /// 
  /// Status changes include: dismissed, forward, reverse, completed.
  /// Useful for triggering actions when animations start, complete, or are dismissed.
  void addStatusListener(AnimationStatusListener listener) {
    _controller.addStatusListener(listener);
  }

  @override
  /// Removes a previously registered value change listener.
  /// 
  /// Should be called to prevent memory leaks when the listener is no longer needed.
  void removeListener(VoidCallback listener) {
    _controller.removeListener(listener);
  }

  @override
  /// Removes a previously registered status change listener.
  /// 
  /// Should be called to prevent memory leaks when the listener is no longer needed.
  void removeStatusListener(AnimationStatusListener listener) {
    _controller.removeStatusListener(listener);
  }

  @override
  /// The current status of the animation.
  /// 
  /// Can be: dismissed, forward, reverse, or completed.
  /// Reflects the underlying controller's animation state.
  AnimationStatus get status => _controller.status;

  @override
  /// The current interpolated value of the animation.
  /// 
  /// Calculates the value between [_from] and [_to] based on the controller's
  /// progress and the specified curve transformation.
  double get value =>
      _from + (_to - _from) * _curve.transform(_controller.value);
}

/// Utility class providing interpolation transformers for common data types.
/// 
/// This class contains static methods for interpolating between values of
/// different types during animations. Each transformer handles null safety
/// and implements appropriate mathematical interpolation.
/// 
/// Used internally by the animation system but can be used directly for
/// custom animation implementations.
class Transformers {
  /// Interpolates between two double values.
  /// 
  /// Returns null if either input is null, otherwise performs linear
  /// interpolation using the standard formula: a + (b - a) * t
  /// 
  /// Parameters:
  /// - [a] (double?): Start value
  /// - [b] (double?): End value  
  /// - [t] (double): Interpolation factor (0.0 to 1.0)
  /// 
  /// Example:
  /// ```dart
  /// final result = Transformers.typeDouble(0.0, 100.0, 0.5); // Returns 50.0
  /// ```
  static double? typeDouble(double? a, double? b, double t) {
    if (a == null || b == null) {
      return null;
    }
    return a + (b - a) * t;
  }

  /// Interpolates between two integer values with rounding.
  /// 
  /// Returns null if either input is null, otherwise performs linear
  /// interpolation and rounds the result to the nearest integer.
  /// 
  /// Parameters:
  /// - [a] (int?): Start value
  /// - [b] (int?): End value
  /// - [t] (double): Interpolation factor (0.0 to 1.0)
  /// 
  /// Example:
  /// ```dart
  /// final result = Transformers.typeInt(10, 20, 0.3); // Returns 13
  /// ```
  static int? typeInt(int? a, int? b, double t) {
    if (a == null || b == null) {
      return null;
    }
    return (a + (b - a) * t).round();
  }

  /// Interpolates between two Color values using Flutter's Color.lerp.
  /// 
  /// Returns null if either input is null, otherwise uses Flutter's
  /// built-in color interpolation which handles ARGB components separately.
  /// 
  /// Parameters:
  /// - [a] (Color?): Start color
  /// - [b] (Color?): End color
  /// - [t] (double): Interpolation factor (0.0 to 1.0)
  /// 
  /// Example:
  /// ```dart
  /// final result = Transformers.typeColor(Colors.red, Colors.blue, 0.5);
  /// ```
  static Color? typeColor(Color? a, Color? b, double t) {
    if (a == null || b == null) {
      return null;
    }
    return Color.lerp(a, b, t);
  }

  /// Interpolates between two Offset values.
  /// 
  /// Returns null if either input is null, otherwise interpolates
  /// both dx and dy components separately using linear interpolation.
  /// 
  /// Parameters:
  /// - [a] (Offset?): Start offset
  /// - [b] (Offset?): End offset
  /// - [t] (double): Interpolation factor (0.0 to 1.0)
  /// 
  /// Example:
  /// ```dart
  /// final result = Transformers.typeOffset(
  ///   Offset(0, 0), 
  ///   Offset(100, 100), 
  ///   0.5
  /// ); // Returns Offset(50, 50)
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

  /// Interpolates between two Size values.
  /// 
  /// Returns null if either input is null, otherwise interpolates
  /// both width and height components separately using linear interpolation.
  /// 
  /// Parameters:
  /// - [a] (Size?): Start size
  /// - [b] (Size?): End size
  /// - [t] (double): Interpolation factor (0.0 to 1.0)
  /// 
  /// Example:
  /// ```dart
  /// final result = Transformers.typeSize(
  ///   Size(10, 20), 
  ///   Size(50, 80), 
  ///   0.5
  /// ); // Returns Size(30, 50)
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

/// A mixin that provides animated property management for StatefulWidgets.
/// 
/// This mixin extends TickerProviderStateMixin to provide a convenient
/// system for creating and managing animated properties. It automatically
/// handles controller lifecycle and provides type-safe convenience methods
/// for common data types.
/// 
/// The mixin manages a collection of animated properties and ensures proper
/// disposal of animation controllers to prevent memory leaks.
/// 
/// Example:
/// ```dart
/// class MyWidget extends StatefulWidget {
///   const MyWidget({Key? key}) : super(key: key);
/// 
///   @override
///   State<MyWidget> createState() => _MyWidgetState();
/// }
/// 
/// class _MyWidgetState extends State<MyWidget> 
///     with TickerProviderStateMixin, AnimatedMixin {
///   late final AnimatedProperty<double> opacity;
///   late final AnimatedProperty<Color> color;
/// 
///   @override
///   void initState() {
///     super.initState();
///     opacity = createAnimatedDouble(0.0);
///     color = createAnimatedColor(Colors.transparent);
///   }
/// 
///   void fadeIn() {
///     opacity.animateTo(1.0, duration: Duration(seconds: 1));
///     color.animateTo(Colors.blue, duration: Duration(seconds: 1));
///   }
/// }
/// ```
mixin AnimatedMixin on TickerProviderStateMixin {
  final List<AnimatedProperty> _animatedProperties = [];
  
  /// Creates a generic animated property with custom interpolation.
  /// 
  /// This is the base method for creating animated properties of any type.
  /// Requires a custom interpolation function to handle value transitions.
  /// 
  /// Parameters:
  /// - [value] (T): Initial value of the property
  /// - [lerp] (PropertyLerp<T>): Function to interpolate between values
  /// 
  /// Returns:
  /// An [AnimatedProperty] instance that can be animated to different values.
  /// 
  /// Example:
  /// ```dart
  /// final animatedRect = createAnimatedProperty(
  ///   Rect.zero,
  ///   (a, b, t) => Rect.lerp(a, b, t),
  /// );
  /// ```
  AnimatedProperty<T> createAnimatedProperty<T>(T value, PropertyLerp<T> lerp) {
    final property = AnimatedProperty._(this, value, lerp, setState);
    _animatedProperties.add(property);
    return property;
  }

  @override
  /// Disposes all managed animated properties.
  /// 
  /// Automatically called when the widget is disposed, ensuring that all
  /// animation controllers are properly disposed to prevent memory leaks.
  void dispose() {
    for (final property in _animatedProperties) {
      property._controller.dispose();
    }
    super.dispose();
  }

  /// Creates an animated integer property.
  /// 
  /// Convenience method that creates an animated property for integer values
  /// using the built-in integer interpolation with rounding.
  /// 
  /// Parameters:
  /// - [value] (int): Initial integer value
  /// 
  /// Returns:
  /// An [AnimatedProperty<int>] ready for animation.
  /// 
  /// Example:
  /// ```dart
  /// final animatedCount = createAnimatedInt(0);
  /// animatedCount.animateTo(100, duration: Duration(seconds: 2));
  /// ```
  AnimatedProperty<int> createAnimatedInt(int value) {
    return createAnimatedProperty(value, Transformers.typeInt);
  }

  /// Creates an animated double property.
  /// 
  /// Convenience method that creates an animated property for double values
  /// using linear interpolation. Most commonly used for opacity, scale,
  /// position, and other floating-point properties.
  /// 
  /// Parameters:
  /// - [value] (double): Initial double value
  /// 
  /// Returns:
  /// An [AnimatedProperty<double>] ready for animation.
  /// 
  /// Example:
  /// ```dart
  /// final animatedOpacity = createAnimatedDouble(0.0);
  /// animatedOpacity.animateTo(1.0, duration: Duration(milliseconds: 300));
  /// ```
  AnimatedProperty<double> createAnimatedDouble(double value) {
    return createAnimatedProperty(value, Transformers.typeDouble);
  }

  /// Creates an animated Color property.
  /// 
  /// Convenience method that creates an animated property for Color values
  /// using Flutter's built-in color interpolation which handles ARGB
  /// components separately for smooth color transitions.
  /// 
  /// Parameters:
  /// - [value] (Color): Initial color value
  /// 
  /// Returns:
  /// An [AnimatedProperty<Color>] ready for animation.
  /// 
  /// Example:
  /// ```dart
  /// final animatedColor = createAnimatedColor(Colors.red);
  /// animatedColor.animateTo(Colors.blue, 
  ///   duration: Duration(seconds: 1),
  ///   curve: Curves.easeInOut
  /// );
  /// ```
  AnimatedProperty<Color> createAnimatedColor(Color value) {
    return createAnimatedProperty(value, Transformers.typeColor);
  }
}

/// A property that can be animated between different values of type [T].
/// 
/// AnimatedProperty provides a high-level interface for animating values
/// with automatic interpolation and state management. It wraps an
/// AnimationController and uses a custom interpolation function to
/// smoothly transition between values.
/// 
/// The property maintains both current and target values, automatically
/// handling the transition between them when animated. It integrates with
/// Flutter's animation system and triggers widget rebuilds through the
/// provided update callback.
/// 
/// Example:
/// ```dart
/// class _MyWidgetState extends State<MyWidget> with AnimatedMixin {
///   late final AnimatedProperty<double> opacity;
/// 
///   @override
///   void initState() {
///     super.initState();
///     opacity = createAnimatedDouble(0.0);
///   }
/// 
///   void fadeIn() {
///     opacity.animateTo(1.0, duration: Duration(seconds: 1));
///   }
/// 
///   @override
///   Widget build(BuildContext context) {
///     return Opacity(
///       opacity: opacity.value,
///       child: child,
///     );
///   }
/// }
/// ```
class AnimatedProperty<T> {
  void _empty() {}
  final TickerProvider _vsync;
  final PropertyLerp<T> _lerp;
  T _value;
  bool _hasTarget = false;
  late T _target;
  late AnimationController _controller;

  /// Creates an [AnimatedProperty] with the specified parameters.
  /// 
  /// This constructor is typically called internally by [AnimatedMixin]
  /// rather than being used directly. The constructor sets up the
  /// animation controller and configures callbacks for state updates.
  /// 
  /// Parameters:
  /// - [_vsync] (TickerProvider): Provides vsync for animation controller
  /// - [_value] (T): Initial value of the property
  /// - [_lerp] (PropertyLerp<T>): Interpolation function for value transitions
  /// - [update] (Function): Callback to trigger widget rebuilds
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

  /// The current value of the animated property.
  /// 
  /// If an animation is in progress, returns the interpolated value
  /// between the start and target values. Otherwise, returns the
  /// static current value.
  /// 
  /// This getter is typically called from the widget's build method
  /// to get the current value for rendering.
  T get value {
    if (_hasTarget) {
      return _lerp(_value!, _target!, _controller.value)!;
    }
    return _value;
  }

  /// Sets the property value directly without animation.
  /// 
  /// Immediately updates the property to the new value, canceling
  /// any in-progress animations. Use this for instant updates or
  /// initialization. For smooth transitions, use [animateTo] instead.
  /// 
  /// Parameters:
  /// - [value] (T): The new value to set
  set value(T value) {
    if (_hasTarget) {
      _controller.reset();
      _controller.forward();
    }
    _target = value;
  }
}

/// Represents a single animation request with timing and easing parameters.
/// 
/// This class encapsulates the parameters needed to perform a single
/// animation: the target value, duration, and easing curve. It's used
/// internally by animation queue systems to manage multiple sequential
/// or overlapping animations.
/// 
/// Example:
/// ```dart
/// final request = AnimationRequest(1.0, Duration(seconds: 1), Curves.easeOut);
/// ```
class AnimationRequest {
  /// The target value to animate to.
  final double target;
  
  /// How long the animation should take to complete.
  final Duration duration;
  
  /// The easing curve to use for the animation.
  final Curve curve;

  /// Creates an [AnimationRequest] with the specified parameters.
  /// 
  /// Parameters:
  /// - [target] (double): The value to animate to
  /// - [duration] (Duration): Animation duration
  /// - [curve] (Curve): Easing curve for the animation
  AnimationRequest(this.target, this.duration, this.curve);
}

/// Manages the execution of a single animation with progress tracking.
/// 
/// AnimationRunner handles the low-level execution of an animation request,
/// tracking progress and computing intermediate values. It maintains the
/// start and end values, timing parameters, and current progress state.
/// 
/// This class is used internally by animation queue systems to execute
/// individual animation segments.
class AnimationRunner {
  /// The starting value of the animation.
  final double from;
  
  /// The target value of the animation.
  final double to;
  
  /// The total duration for the animation.
  final Duration duration;
  
  /// The easing curve to apply to the animation.
  final Curve curve;
  
  /// Current progress of the animation (0.0 to 1.0).
  double _progress = 0.0;

  /// Creates an [AnimationRunner] with the specified parameters.
  /// 
  /// Parameters:
  /// - [from] (double): Starting value
  /// - [to] (double): Target value
  /// - [duration] (Duration): Animation duration
  /// - [curve] (Curve): Easing curve
  AnimationRunner(this.from, this.to, this.duration, this.curve);
}

/// A controller that manages a queue of animation requests.
/// 
/// AnimationQueueController provides a high-level interface for managing
/// sequential animations. It maintains a queue of animation requests and
/// executes them in order, allowing for complex animation sequences.
/// 
/// The controller can handle both queued animations (added to the end of
/// the queue) and immediate animations (replacing the entire queue).
/// It provides manual tick-based animation updates for precise control.
/// 
/// Example:
/// ```dart
/// final controller = AnimationQueueController(0.0);
/// 
/// // Add animations to the queue
/// controller.push(AnimationRequest(1.0, Duration(seconds: 1), Curves.easeOut));
/// controller.push(AnimationRequest(0.5, Duration(milliseconds: 500), Curves.easeIn));
/// 
/// // In your animation loop
/// controller.tick(deltaTime);
/// final currentValue = controller.value;
/// ```
class AnimationQueueController extends ChangeNotifier {
  double _value;

  /// Creates an [AnimationQueueController] with an optional initial value.
  /// 
  /// Parameters:
  /// - [_value] (double, default: 0.0): Initial value of the animation
  AnimationQueueController([this._value = 0.0]);

  List<AnimationRequest> _requests = [];
  AnimationRunner? _runner;

  /// Adds an animation request to the controller.
  /// 
  /// Parameters:
  /// - [request] (AnimationRequest): The animation to add
  /// - [queue] (bool, default: true): Whether to queue or replace existing animations
  /// 
  /// When [queue] is true, the request is added to the end of the animation
  /// queue. When false, all pending animations are cleared and the new
  /// request becomes the only animation.
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

  /// Sets the animation value directly, clearing all pending animations.
  /// 
  /// This immediately jumps to the specified value and cancels any
  /// running or queued animations. Use this to reset or initialize
  /// the animation state.
  /// 
  /// Parameters:
  /// - [value] (double): The new value to set
  set value(double value) {
    _value = value;
    _runner = null;
    _requests.clear();
    notifyListeners();
  }

  /// The current value of the animation.
  /// 
  /// This represents the current animated value, which may be interpolated
  /// between keyframes if an animation is currently running.
  double get value => _value;

  /// Whether the controller has active animations that need tick updates.
  /// 
  /// Returns true if there are any running animations or pending requests
  /// that require the animation system to continue calling [tick].
  bool get shouldTick => _runner != null || _requests.isNotEmpty;

  /// Updates the animation progress by the specified time delta.
  /// 
  /// This method should be called regularly (typically every frame) with
  /// the time elapsed since the last call. It advances the current animation
  /// and processes queued animations as they complete.
  /// 
  /// Parameters:
  /// - [delta] (Duration): Time elapsed since the last tick
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

/// Abstract base class for animation keyframes in timeline-based animations.
/// 
/// A keyframe defines a specific point in an animation timeline with a duration
/// and a method to compute the value at that point. Keyframes are building blocks
/// for complex, multi-segment animations.
/// 
/// Different keyframe types provide various interpolation behaviors:
/// - [AbsoluteKeyframe]: Animates between specific start and end values
/// - [RelativeKeyframe]: Animates from the previous keyframe's value to a target
/// - [StillKeyframe]: Holds a constant value for the specified duration
abstract class Keyframe<T> {
  /// The duration this keyframe should take to complete.
  Duration get duration;
  
  /// Computes the value for this keyframe at the given progress.
  /// 
  /// Parameters:
  /// - [timeline] (TimelineAnimation<T>): The timeline context
  /// - [index] (int): Index of this keyframe in the timeline
  /// - [t] (double): Progress within this keyframe (0.0 to 1.0)
  /// 
  /// Returns:
  /// The computed value at the specified progress point.
  T compute(TimelineAnimation<T> timeline, int index, double t);
}

/// A keyframe that animates between explicit start and end values.
/// 
/// AbsoluteKeyframe provides precise control over both the starting and
/// ending values of an animation segment. This is useful when you need
/// to ensure specific values regardless of the previous animation state.
/// 
/// Example:
/// ```dart
/// final keyframe = AbsoluteKeyframe<double>(
///   Duration(seconds: 1),
///   0.0,  // from
///   1.0,  // to
/// );
/// ```
class AbsoluteKeyframe<T> implements Keyframe<T> {
  /// The starting value for this keyframe.
  final T from;
  
  /// The ending value for this keyframe.
  final T to;
  
  @override
  /// The duration this keyframe takes to complete.
  final Duration duration;

  /// Creates an [AbsoluteKeyframe] with explicit start and end values.
  /// 
  /// Parameters:
  /// - [duration] (Duration): How long this keyframe takes
  /// - [from] (T): Starting value
  /// - [to] (T): Ending value
  const AbsoluteKeyframe(
    this.duration,
    this.from,
    this.to,
  );

  @override
  /// Computes the interpolated value between [from] and [to] at progress [t].
  T compute(TimelineAnimation<T> timeline, int index, double t) {
    return timeline.lerp(from!, to!, t)!;
  }
}

/// A keyframe that animates from the previous keyframe's value to a target.
/// 
/// RelativeKeyframe creates smooth transitions by automatically using the
/// end value of the previous keyframe as its starting point. This ensures
/// continuous animations without jumps between segments.
/// 
/// Example:
/// ```dart
/// final keyframe = RelativeKeyframe<double>(
///   Duration(milliseconds: 500),
///   0.8,  // target value
/// );
/// ```
class RelativeKeyframe<T> implements Keyframe<T> {
  /// The target value to animate to from the previous keyframe's end value.
  final T target;
  
  @override
  /// The duration this keyframe takes to complete.
  final Duration duration;

  /// Creates a [RelativeKeyframe] that animates to the target value.
  /// 
  /// Parameters:
  /// - [duration] (Duration): How long this keyframe takes
  /// - [target] (T): The value to animate to
  const RelativeKeyframe(
    this.duration,
    this.target,
  );

  @override
  /// Computes the interpolated value from the previous keyframe to [target].
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

/// A keyframe that maintains a constant value for its duration.
/// 
/// StillKeyframe is useful for creating pauses in animations or holding
/// specific values for a period of time. It can hold either an explicit
/// value or maintain the previous keyframe's end value.
/// 
/// Example:
/// ```dart
/// // Hold an explicit value
/// final keyframe1 = StillKeyframe<double>(Duration(seconds: 1), 0.5);
/// 
/// // Hold the previous keyframe's value
/// final keyframe2 = StillKeyframe<double>(Duration(milliseconds: 300));
/// ```
class StillKeyframe<T> implements Keyframe<T> {
  /// The value to hold, or null to use the previous keyframe's end value.
  final T? value;
  
  @override
  /// The duration to hold the value.
  final Duration duration;

  /// Creates a [StillKeyframe] with an optional explicit value.
  /// 
  /// Parameters:
  /// - [duration] (Duration): How long to hold the value
  /// - [value] (T?, optional): Value to hold, or null to use previous value
  const StillKeyframe(this.duration, [this.value]);

  @override
  /// Returns the constant value for this keyframe.
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

/// An animatable wrapper that scales timeline animations to fit a specific duration.
/// 
/// TimelineAnimatable allows you to embed a timeline animation within a larger
/// animation system, scaling the timeline to match the desired duration. This
/// enables timeline animations to be used with standard Flutter animation
/// controllers and curves.
/// 
/// The wrapper handles timing conversion between the animation controller's
/// progress (0.0 to 1.0) and the timeline's internal duration system.
class TimelineAnimatable<T> extends Animatable<T> {
  /// The desired duration for this animatable within the parent animation.
  final Duration duration;
  
  /// The timeline animation to be scaled and embedded.
  final TimelineAnimation<T> animation;

  /// Creates a [TimelineAnimatable] with the specified duration and animation.
  /// 
  /// Parameters:
  /// - [duration] (Duration): Target duration for the animation
  /// - [animation] (TimelineAnimation<T>): Timeline to embed
  TimelineAnimatable(this.duration, this.animation);

  @override
  /// Transforms the animation progress to match the timeline's timing.
  /// 
  /// Converts the normalized progress (0.0 to 1.0) from the animation
  /// controller into the appropriate timeline progress based on the
  /// duration scaling factor.
  T transform(double t) {
    Duration selfDuration = animation.totalDuration;
    double selfT = (t * selfDuration.inMilliseconds) / duration.inMilliseconds;
    return animation.transform(selfT);
  }
}

/// A complex animation system that manages sequences of keyframes over time.
/// 
/// TimelineAnimation provides a high-level interface for creating complex,
/// multi-segment animations using keyframes. Each keyframe defines a portion
/// of the animation with its own duration and behavior, allowing for
/// sophisticated animation sequences.
/// 
/// The timeline automatically manages timing calculations and provides
/// smooth transitions between keyframes using customizable interpolation
/// functions.
/// 
/// Example:
/// ```dart
/// final timeline = TimelineAnimation<double>(
///   keyframes: [
///     AbsoluteKeyframe(Duration(seconds: 1), 0.0, 1.0),
///     StillKeyframe(Duration(milliseconds: 500), 1.0),
///     RelativeKeyframe(Duration(seconds: 1), 0.0),
///   ],
/// );
/// 
/// final controller = AnimationController(
///   duration: timeline.totalDuration,
///   vsync: this,
/// );
/// 
/// final animation = timeline.drive(controller);
/// ```
class TimelineAnimation<T> extends Animatable<T> {
  /// Default interpolation function for types that support arithmetic operations.
  /// 
  /// This provides basic linear interpolation for numeric types and other
  /// types that implement arithmetic operators. Falls back to dynamic
  /// type casting for flexibility.
  static T defaultLerp<T>(T a, T b, double t) {
    return ((a as dynamic) + ((b as dynamic) - (a as dynamic)) * t) as T;
  }

  /// The interpolation function used to blend between values.
  final PropertyLerp<T> lerp;
  
  /// The total duration of all keyframes combined.
  final Duration totalDuration;
  
  /// The list of keyframes that define the animation sequence.
  final List<Keyframe<T>> keyframes;

  /// Private constructor for internal use.
  TimelineAnimation._({
    required this.lerp,
    required this.totalDuration,
    required this.keyframes,
  });

  /// Creates a [TimelineAnimation] with the specified keyframes and interpolation.
  /// 
  /// The total duration is automatically calculated from all keyframes.
  /// If no interpolation function is provided, uses [defaultLerp].
  /// 
  /// Parameters:
  /// - [lerp] (PropertyLerp<T>?, optional): Custom interpolation function
  /// - [keyframes] (List<Keyframe<T>>): The animation keyframes
  /// 
  /// Throws:
  /// - AssertionError if keyframes list is empty
  /// - AssertionError if any keyframe has invalid duration
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

  /// Computes the duration elapsed at the given progress.
  /// 
  /// Parameters:
  /// - [t] (double): Progress from 0.0 to 1.0
  /// 
  /// Returns:
  /// The duration that corresponds to the given progress point.
  Duration _computeDuration(double t) {
    final totalDuration = this.totalDuration;
    return Duration(milliseconds: (t * totalDuration.inMilliseconds).floor());
  }

  /// Creates an [TimelineAnimatable] driven by the given controller.
  /// 
  /// This allows the timeline to be used with a standard Flutter
  /// [AnimationController], automatically scaling the timeline duration
  /// to match the controller's duration.
  /// 
  /// Parameters:
  /// - [controller] (AnimationController): The controller to drive the timeline
  /// 
  /// Returns:
  /// A [TimelineAnimatable] that wraps this timeline.
  TimelineAnimatable<T> drive(AnimationController controller) {
    return TimelineAnimatable(controller.duration!, this);
  }

  /// Directly computes the timeline value for the given controller's progress.
  /// 
  /// Convenience method that combines [drive] and [transform] into a single call.
  /// Useful for one-off value computations without creating an animatable wrapper.
  /// 
  /// Parameters:
  /// - [controller] (AnimationController): The controller providing progress
  /// 
  /// Returns:
  /// The computed value at the controller's current progress.
  T transformWithController(AnimationController controller) {
    return drive(controller).transform(controller.value);
  }

  /// Creates an [TimelineAnimatable] with a custom total duration.
  /// 
  /// This method allows you to override the timeline's natural duration,
  /// creating time scaling effects. The timeline will be compressed or
  /// expanded to fit the specified duration.
  /// 
  /// Parameters:
  /// - [duration] (Duration): The desired total duration
  /// 
  /// Returns:
  /// A [TimelineAnimatable] that scales this timeline to the specified duration.
  /// 
  /// Example:
  /// ```dart
  /// // Timeline has natural 3-second duration, scale to 1 second
  /// final scaled = timeline.withTotalDuration(Duration(seconds: 1));
  /// ```
  TimelineAnimatable<T> withTotalDuration(Duration duration) {
    return TimelineAnimatable(duration, this);
  }

  @override
  /// Computes the timeline value at the specified progress.
  /// 
  /// This is the core method that traverses the keyframes and computes
  /// the appropriate value based on the animation progress. It handles
  /// finding the correct keyframe segment and calculating the local
  /// progress within that segment.
  /// 
  /// Parameters:
  /// - [t] (double): Animation progress from 0.0 to 1.0
  /// 
  /// Returns:
  /// The computed value at the specified progress point.
  /// 
  /// Throws:
  /// - AssertionError if t is outside the valid range [0.0, 1.0]
  /// - AssertionError if no keyframes are defined
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

/// Returns the maximum of two duration values.
/// 
/// Utility function for comparing durations and returning the longer one.
/// Useful for animation timing calculations and synchronization.
/// 
/// Parameters:
/// - [a] (Duration): First duration
/// - [b] (Duration): Second duration
/// 
/// Returns:
/// The duration with the greater length.
/// 
/// Example:
/// ```dart
/// final longer = maxDuration(
///   Duration(seconds: 1),
///   Duration(milliseconds: 500),
/// ); // Returns Duration(seconds: 1)
/// ```
Duration maxDuration(Duration a, Duration b) {
  return a > b ? a : b;
}

Duration minDuration(Duration a, Duration b) {
  return a < b ? a : b;
}

Duration timelineMaxDuration(Iterable<TimelineAnimation> timelines) {
  Duration max = Duration.zero;
  for (final timeline in timelines) {
    max = maxDuration(max, timeline.totalDuration);
  }
  return max;
}
