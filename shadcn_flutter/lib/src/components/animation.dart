import 'package:flutter/widgets.dart';

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
    Key? key,
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
            'You must provide a duration or a durationBuilder.'),
        super(key: key);

  const AnimatedValueBuilder.animation({
    Key? key,
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
            'You must provide a duration or a durationBuilder.'),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AnimatedValueBuilderState<T>();
  }
}

class _AnimatableValue<T> extends Animatable<T> {
  final T start;
  final T end;
  final T Function(T a, T b, double t) lerp;
  final Curve curve;

  _AnimatableValue({
    required this.start,
    required this.end,
    required this.lerp,
    required this.curve,
  });

  @override
  T transform(double t) {
    return lerp(start, end, curve.transform(t));
  }
}

class AnimatedValueBuilderState<T> extends State<AnimatedValueBuilder<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
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
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _onEnd();
      }
    });
    _animation = _controller.drive(
      _AnimatableValue(
        start: widget.initialValue ?? widget.value,
        end: widget.value,
        lerp: lerpedValue,
        curve: widget.curve,
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
    if (oldWidget.value != widget.value ||
        oldWidget.duration != widget.duration ||
        oldWidget.curve != widget.curve ||
        oldWidget.durationBuilder != widget.durationBuilder) {
      T currentValue = _animation.value;
      _controller.duration = widget.duration ??
          widget.durationBuilder!(currentValue, widget.value);
      _animation = _controller.drive(
        _AnimatableValue(
          start: currentValue,
          end: widget.value,
          lerp: lerpedValue,
          curve: widget.curve,
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
    double progress = _controller.value;
    if (progress == 1) {
      return widget.builder!(context, widget.value, widget.child);
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

class _AnimationStatusDependentCurve extends Curve {
  final AnimationController controller;
  final Curve curve;
  final Curve reverseCurve;

  _AnimationStatusDependentCurve({
    required this.controller,
    required this.curve,
    required this.reverseCurve,
  });

  @override
  double transform(double t) {
    if (controller.status == AnimationStatus.reverse) {
      return reverseCurve.transform(t);
    }
    return curve.transform(t);
  }
}

class _RepeatedAnimationBuilderState<T>
    extends State<RepeatedAnimationBuilder<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
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
      _animation = _controller.drive(
        _AnimatableValue(
          start: widget.end,
          end: widget.start,
          lerp: lerpedValue,
          curve: _AnimationStatusDependentCurve(
            controller: _controller,
            curve: widget.reverseCurve ?? widget.curve,
            reverseCurve: widget.curve,
          ),
        ),
      );
    } else {
      _controller.duration = widget.duration;
      _controller.reverseDuration = widget.reverseDuration;
      _animation = _controller.drive(
        _AnimatableValue(
          start: widget.start,
          end: widget.end,
          lerp: lerpedValue,
          curve: _AnimationStatusDependentCurve(
            controller: _controller,
            curve: widget.curve,
            reverseCurve: widget.reverseCurve ?? widget.curve,
          ),
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
        _animation = _controller.drive(
          _AnimatableValue(
            start: widget.end,
            end: widget.start,
            lerp: lerpedValue,
            // curve: widget.reverseCurve ?? widget.curve,
            curve: _AnimationStatusDependentCurve(
              controller: _controller,
              reverseCurve: widget.curve,
              curve: widget.reverseCurve ?? widget.curve,
            ),
          ),
        );
      } else {
        _controller.duration = widget.duration;
        _controller.reverseDuration = widget.reverseDuration;
        _animation = _controller.drive(
          _AnimatableValue(
            start: widget.start,
            end: widget.end,
            lerp: lerpedValue,
            // curve: widget.curve,
            curve: _AnimationStatusDependentCurve(
              controller: _controller,
              curve: widget.curve,
              reverseCurve: widget.reverseCurve ?? widget.curve,
            ),
          ),
        );
      }
      _controller.stop(canceled: false);
      if (widget.play) {
        if (_reverse) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
      }
    }
  }

  @override
  void dispose() {
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

  @override
  double transform(double t) {
    double progressStartInterval;
    double progressEndInterval;
    if (start != null) {
      progressStartInterval = start!.inMilliseconds / duration.inMilliseconds;
    } else {
      progressStartInterval = 0;
    }
    if (end != null) {
      progressEndInterval = end!.inMilliseconds / duration.inMilliseconds;
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
