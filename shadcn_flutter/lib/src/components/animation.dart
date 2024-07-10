import 'package:flutter/widgets.dart';

class AnimatedValueBuilder<T> extends StatefulWidget {
  final T? initialValue;
  final T value;
  final Duration duration;
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final void Function(T value)? onEnd;
  final Curve curve;
  final T Function(T a, T b, double t)? lerp;
  final Widget? child;

  const AnimatedValueBuilder({
    Key? key,
    this.initialValue,
    required this.value,
    required this.duration,
    required this.builder,
    this.onEnd,
    this.curve = Curves.linear,
    this.lerp,
    this.child,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AnimatedValueBuilderState<T>();
  }
}

class AnimatedValueBuilderState<T> extends State<AnimatedValueBuilder<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late T _value;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _onEnd();
      }
    });
    _controller.addListener(() {
      setState(() {});
    });
    _value = widget.initialValue ?? widget.value;
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
        oldWidget.curve != widget.curve) {
      T currentValue = lerpedValue(
        _value,
        oldWidget.value,
        oldWidget.curve.transform(_controller.value),
      );
      _controller.duration = widget.duration;
      _controller.reset();
      _controller.forward();
      _value = currentValue;
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
    double progress = _controller.value;
    double curveProgress = widget.curve.transform(progress);
    if (progress == 1) {
      return widget.builder(context, widget.value, widget.child);
    }
    T newValue = lerpedValue(_value, widget.value, curveProgress);
    return widget.builder(context, newValue, widget.child);
  }
}

enum RepeatMode {
  repeat,
  reverse,
  pingPong,
}

class RepeatedAnimationBuilder<T> extends StatefulWidget {
  final T start;
  final T end;
  final Duration duration;
  final Duration? reverseDuration;
  final Curve curve;
  final Curve? reverseCurve;
  final RepeatMode mode;
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final Widget? child;
  final T Function(T a, T b, double t)? lerp;
  final bool play;

  const RepeatedAnimationBuilder({
    Key? key,
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
  }) : super(key: key);

  @override
  State<RepeatedAnimationBuilder<T>> createState() =>
      _RepeatedAnimationBuilderState<T>();
}

class _RepeatedAnimationBuilderState<T>
    extends State<RepeatedAnimationBuilder<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      reverseDuration: widget.reverseDuration,
    );
    if (widget.play) {
      switch (widget.mode) {
        case RepeatMode.repeat:
          _controller.repeat(reverse: false);
          break;
        case RepeatMode.reverse:
          _controller.repeat(reverse: false);
          break;
        case RepeatMode.pingPong:
          _controller.repeat(reverse: true);
          break;
      }
    }
  }

  @override
  void didUpdateWidget(covariant RepeatedAnimationBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.start != widget.start ||
        oldWidget.end != widget.end ||
        oldWidget.duration != widget.duration ||
        oldWidget.reverseDuration != widget.reverseDuration) {
      _controller.duration = widget.duration;
      _controller.reverseDuration = widget.reverseDuration;
      _controller.stop();
      if (widget.play) {
        switch (widget.mode) {
          case RepeatMode.repeat:
            _controller.repeat(reverse: false);
            break;
          case RepeatMode.reverse:
            _controller.repeat(reverse: false);
            break;
          case RepeatMode.pingPong:
            _controller.repeat(reverse: true);
            break;
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double progress = _controller.value;
        AnimationStatus status = _controller.status;
        if (widget.mode == RepeatMode.reverse) {
          progress = 1 - progress;
        }
        double curveProgress = status == AnimationStatus.reverse ||
                widget.mode == RepeatMode.reverse
            ? (widget.reverseCurve ?? widget.curve).transform(progress)
            : widget.curve.transform(progress);
        T value = lerpedValue(widget.start, widget.end, curveProgress);
        return widget.builder(context, value, widget.child);
      },
    );
  }
}
