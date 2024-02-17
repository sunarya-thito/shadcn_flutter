import 'package:flutter/widgets.dart';

class AnimatedValueBuilder<T> extends StatefulWidget {
  final T? initialValue;
  final T value;
  final Duration duration;
  final Widget Function(BuildContext context, T value) builder;
  final void Function(T value)? onEnd;
  final Curve curve;
  final T Function(T a, T b, double t)? lerp;

  const AnimatedValueBuilder({
    Key? key,
    this.initialValue,
    required this.value,
    required this.duration,
    required this.builder,
    this.onEnd,
    this.curve = Curves.linear,
    this.lerp,
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
      _controller.duration = widget.duration;
      _controller.reset();
      _controller.forward();
      double curveProgress = widget.curve.transform(_controller.value);
      _value = lerpedValue(oldWidget.value, widget.value, curveProgress);
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
      return widget.builder(context, widget.value);
    }
    T newValue = lerpedValue(_value, widget.value, curveProgress);
    return widget.builder(context, newValue);
  }
}
