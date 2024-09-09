import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/src/util.dart';

typedef AnimatedChildBuilder<T> = Widget Function(
    BuildContext context, T value, Widget? child);
typedef AnimationBuilder<T> = Widget Function(
    BuildContext context, Animation<T> animation);

class AnimatedValueBuilder<T> extends StatefulWidget {
  final T? initialValue;
  final T value;
  final Duration? duration;
  final Duration Function(T a, T b)? durationBuilder;
  final AnimatedChildBuilder<T>? builder;
  final AnimationBuilder<T>? animationBuilder;
  final void Function(T value)? onEnd;
  final Curve curve;
  final T Function(T a, T b, double t)? lerp;
  final Widget? child;

  const AnimatedValueBuilder({
    super.key,
    this.initialValue,
    required this.value,
    this.duration,
    this.durationBuilder,
    required AnimatedChildBuilder<T> this.builder,
    this.onEnd,
    this.curve = Curves.linear,
    this.lerp,
    this.child,
  })  : animationBuilder = null,
        assert(duration != null || durationBuilder != null,
            'You must provide a duration or a durationBuilder.');

  const AnimatedValueBuilder.animation({
    super.key,
    this.initialValue,
    required this.value,
    this.duration,
    this.durationBuilder,
    required AnimationBuilder<T> builder,
    this.onEnd,
    this.curve = Curves.linear,
    this.lerp,
  })  : builder = null,
        animationBuilder = builder,
        child = null,
        assert(duration != null || durationBuilder != null,
            'You must provide a duration or a durationBuilder.');

  @override
  State<StatefulWidget> createState() {
    return AnimatedValueBuilderState<T>();
  }
}

class _AnimatableValue<T> extends Animatable<T> {
  final T start;
  final T end;
  final T Function(T a, T b, double t) lerp;

  _AnimatableValue({
    required this.start,
    required this.end,
    required this.lerp,
  });

  @override
  T transform(double t) {
    return lerp(start, end, t);
  }
}

class AnimatedValueBuilderState<T> extends State<AnimatedValueBuilder<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _curvedAnimation;
  late Animation<T> _animation;
  // late T _value;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: widget.duration ??
            widget.durationBuilder!(
                widget.initialValue ?? widget.value, widget.value));
    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
    _curvedAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _onEnd();
      }
    });
    _animation = _curvedAnimation.drive(
      _AnimatableValue(
        start: widget.initialValue ?? widget.value,
        end: widget.value,
        lerp: lerpedValue,
      ),
    );
    if (widget.initialValue != null) {
      _controller.forward();
    }
  }

  T lerpedValue(T a, T b, double t) {
    if (widget.lerp != null) {
      return widget.lerp!(a, b, t);
    }
    try {
      return (a as dynamic) + ((b as dynamic) - (a as dynamic)) * t;
    } catch (e) {
      throw Exception(
        'Could not lerp $a and $b. You must provide a custom lerp function.',
      );
    }
  }

  @override
  void didUpdateWidget(AnimatedValueBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    T currentValue = _animation.value;
    if (widget.duration != oldWidget.duration ||
        widget.durationBuilder != oldWidget.durationBuilder) {
      _controller.duration = widget.duration ??
          widget.durationBuilder!(currentValue, widget.value);
    }
    if (widget.curve != oldWidget.curve) {
      _curvedAnimation.dispose();
      _curvedAnimation = CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      );
    }
    if (oldWidget.value != widget.value || oldWidget.lerp != widget.lerp) {
      _animation = _curvedAnimation.drive(
        _AnimatableValue(
          start: currentValue,
          end: widget.value,
          lerp: lerpedValue,
        ),
      );
      _controller.forward(
        from: 0,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onEnd() {
    if (widget.onEnd != null) {
      widget.onEnd!(widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animationBuilder != null) {
      return widget.animationBuilder!(context, _animation);
    }
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        T newValue = _animation.value;
        return widget.builder!(context, newValue, widget.child);
      },
    );
  }
}

enum RepeatMode {
  repeat,
  reverse,
  pingPong,

  /// Same as pingPong, but starts reversed
  pingPongReverse,
}

class RepeatedAnimationBuilder<T> extends StatefulWidget {
  final T start;
  final T end;
  final Duration duration;
  final Duration? reverseDuration;
  final Curve curve;
  final Curve? reverseCurve;
  final RepeatMode mode;
  final Widget Function(BuildContext context, T value, Widget? child)? builder;
  final Widget Function(BuildContext context, Animation<T> animation)?
      animationBuilder;
  final Widget? child;
  final T Function(T a, T b, double t)? lerp;
  final bool play;

  const RepeatedAnimationBuilder({
    super.key,
    required this.start,
    required this.end,
    required this.duration,
    this.curve = Curves.linear,
    this.reverseCurve,
    this.mode = RepeatMode.repeat,
    required this.builder,
    this.child,
    this.lerp,
    this.play = true,
    this.reverseDuration,
  }) : animationBuilder = null;

  const RepeatedAnimationBuilder.animation({
    super.key,
    required this.start,
    required this.end,
    required this.duration,
    this.curve = Curves.linear,
    this.reverseCurve,
    this.mode = RepeatMode.repeat,
    required this.animationBuilder,
    this.child,
    this.lerp,
    this.play = true,
    this.reverseDuration,
  }) : builder = null;

  @override
  State<RepeatedAnimationBuilder<T>> createState() =>
      _RepeatedAnimationBuilderState<T>();
}

class _RepeatedAnimationBuilderState<T>
    extends State<RepeatedAnimationBuilder<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _curvedAnimation;
  late Animation<T> _animation;

  bool _reverse = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
    if (widget.mode == RepeatMode.reverse ||
        widget.mode == RepeatMode.pingPongReverse) {
      _reverse = true;
      _controller.duration = widget.reverseDuration ?? widget.duration;
      _controller.reverseDuration = widget.duration;
      _curvedAnimation = CurvedAnimation(
        parent: _controller,
        curve: widget.reverseCurve ?? widget.curve,
        reverseCurve: widget.curve,
      );
      _animation = _curvedAnimation.drive(
        _AnimatableValue(
          start: widget.end,
          end: widget.start,
          lerp: lerpedValue,
        ),
      );
    } else {
      _controller.duration = widget.duration;
      _controller.reverseDuration = widget.reverseDuration;
      _curvedAnimation = CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
        reverseCurve: widget.reverseCurve ?? widget.curve,
      );
      _animation = _curvedAnimation.drive(
        _AnimatableValue(
          start: widget.start,
          end: widget.end,
          lerp: lerpedValue,
        ),
      );
    }
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (widget.mode == RepeatMode.pingPong ||
            widget.mode == RepeatMode.pingPongReverse) {
          _controller.reverse();
          _reverse = true;
        } else {
          _controller.reset();
          _controller.forward();
        }
      } else if (status == AnimationStatus.dismissed) {
        if (widget.mode == RepeatMode.pingPong ||
            widget.mode == RepeatMode.pingPongReverse) {
          _controller.forward();
          _reverse = false;
        } else {
          _controller.reset();
          _controller.forward();
        }
      }
    });
    if (widget.play) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant RepeatedAnimationBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {}
    if (oldWidget.start != widget.start ||
        oldWidget.end != widget.end ||
        oldWidget.duration != widget.duration ||
        oldWidget.reverseDuration != widget.reverseDuration ||
        oldWidget.curve != widget.curve ||
        oldWidget.reverseCurve != widget.reverseCurve ||
        oldWidget.mode != widget.mode ||
        oldWidget.play != widget.play) {
      if (widget.mode == RepeatMode.reverse ||
          widget.mode == RepeatMode.pingPongReverse) {
        _controller.duration = widget.reverseDuration ?? widget.duration;
        _controller.reverseDuration = widget.duration;
        _curvedAnimation.dispose();
        _curvedAnimation = CurvedAnimation(
          parent: _controller,
          curve: widget.reverseCurve ?? widget.curve,
          reverseCurve: widget.curve,
        );
        _animation = _curvedAnimation.drive(
          _AnimatableValue(
            start: widget.end,
            end: widget.start,
            lerp: lerpedValue,
            // curve: widget.reverseCurve ?? widget.curve,
          ),
        );
      } else {
        _controller.duration = widget.duration;
        _controller.reverseDuration = widget.reverseDuration;
        _curvedAnimation.dispose();
        _curvedAnimation = CurvedAnimation(
          parent: _controller,
          curve: widget.curve,
          reverseCurve: widget.reverseCurve ?? widget.curve,
        );
        _animation = _curvedAnimation.drive(
          _AnimatableValue(
            start: widget.start,
            end: widget.end,
            lerp: lerpedValue,
            // curve: widget.curve,
          ),
        );
      }
    }
    if (oldWidget.play != widget.play) {
      if (widget.play) {
        if (_reverse) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _curvedAnimation.dispose();
    _controller.dispose();
    super.dispose();
  }

  T lerpedValue(T a, T b, double t) {
    if (widget.lerp != null) {
      return widget.lerp!(a, b, t);
    }
    try {
      return (a as dynamic) + ((b as dynamic) - (a as dynamic)) * t;
    } catch (e) {
      throw Exception(
        'Could not lerp $a and $b. You must provide a custom lerp function.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animationBuilder != null) {
      return widget.animationBuilder!(context, _animation);
    }
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        T value = _animation.value;
        return widget.builder!(context, value, widget.child);
      },
    );
  }
}

class IntervalDuration extends Curve {
  final Duration? start;
  final Duration? end;
  final Duration duration;
  final Curve? curve;

  const IntervalDuration({
    this.start,
    this.end,
    required this.duration,
    this.curve,
  });

  factory IntervalDuration.delayed({
    Duration? startDelay,
    Duration? endDelay,
    required Duration duration,
  }) {
    if (startDelay != null) {
      duration += startDelay;
    }
    if (endDelay != null) {
      duration += endDelay;
    }
    return IntervalDuration(
      start: startDelay,
      end: endDelay == null ? null : duration - endDelay,
      duration: duration,
    );
  }

  @override
  double transform(double t) {
    double progressStartInterval;
    double progressEndInterval;
    if (start != null) {
      progressStartInterval = start!.inMicroseconds / duration.inMicroseconds;
    } else {
      progressStartInterval = 0;
    }
    if (end != null) {
      progressEndInterval = end!.inMicroseconds / duration.inMicroseconds;
    } else {
      progressEndInterval = 1;
    }
    double clampedProgress = ((t - progressStartInterval) /
            (progressEndInterval - progressStartInterval))
        .clamp(0, 1);
    if (curve != null) {
      return curve!.transform(clampedProgress);
    }
    return clampedProgress;
  }
}

class CrossFadedTransition extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final AlignmentGeometry alignment;

  const CrossFadedTransition({
    super.key,
    required this.child,
    this.duration = kDefaultDuration,
    this.alignment = Alignment.center,
  });

  @override
  State<CrossFadedTransition> createState() => _CrossFadedTransitionState();
}

class _CrossFadedTransitionState extends State<CrossFadedTransition> {
  late Widget newChild;

  @override
  void initState() {
    super.initState();
    newChild = widget.child;
  }

  @override
  void didUpdateWidget(covariant CrossFadedTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child &&
        oldWidget.child.key != widget.child.key) {
      newChild = widget.child;
    }
  }

  Widget _lerpWidget(Widget a, Widget b, double t) {
    // startOpacity is from 0.0 to 0.5
    // endOpacity is from 0.5 to 1.0
    double startOpacity = 1 - (t.clamp(0, 0.5) * 2);
    double endOpacity = t.clamp(0.5, 1) * 2 - 1;
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Positioned.fill(
          child: Opacity(
              opacity: startOpacity,
              child: Align(
                alignment: widget.alignment,
                child: a,
              )),
        ),
        Opacity(
          opacity: endOpacity,
          child: b,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      alignment: widget.alignment,
      duration: widget.duration,
      child: AnimatedValueBuilder(
        value: newChild,
        lerp: _lerpWidget,
        duration: widget.duration,
        builder: (context, value, child) {
          return value;
        },
      ),
    );
  }
}
