import 'package:flutter/widgets.dart';

typedef PropertyLerp<T> = T Function(T a, T b, double t);

class ControlledAnimation extends Animation<double> {
  final AnimationController _controller;

  ControlledAnimation(this._controller);

  double _from = 0;
  double _to = 1;
  Curve _curve = Curves.linear;

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

class Transformers {
  static PropertyLerp<double> typeDouble = (a, b, t) => a + (b - a) * t;
  static PropertyLerp<int> typeInt = (a, b, t) => (a + (b - a) * t).round();
  static PropertyLerp<Color> typeColor = (a, b, t) => Color.lerp(a, b, t)!;
}

mixin AnimatedMixin on TickerProviderStateMixin {
  final List<AnimatedProperty> _animatedProperties = [];
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

  AnimatedProperty<int> createAnimatedInt(int value) {
    return createAnimatedProperty(value, Transformers.typeInt);
  }

  AnimatedProperty<double> createAnimatedDouble(double value) {
    return createAnimatedProperty(value, Transformers.typeDouble);
  }

  AnimatedProperty<Color> createAnimatedColor(Color value) {
    return createAnimatedProperty(value, Transformers.typeColor);
  }
}

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

  T get value {
    if (_hasTarget) {
      return _lerp(_value, _target, _controller.value);
    }
    return _value;
  }

  set value(T value) {
    if (_hasTarget) {
      _controller.reset();
      _controller.forward();
    }
    _target = value;
  }
}

class AnimationRequest {
  final double target;
  final Duration duration;
  final Curve curve;

  AnimationRequest(this.target, this.duration, this.curve);
}

class AnimationRunner {
  final double from;
  final double to;
  final Duration duration;
  final Curve curve;
  double _progress = 0.0;

  AnimationRunner(this.from, this.to, this.duration, this.curve);
}

class AnimationQueueController extends ChangeNotifier {
  double _value;

  AnimationQueueController([this._value = 0.0]);

  List<AnimationRequest> _requests = [];
  AnimationRunner? _runner;

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

  set value(double value) {
    _value = value;
    _runner = null;
    _requests.clear();
    notifyListeners();
  }

  double get value => _value;

  bool get shouldTick => _runner != null || _requests.isNotEmpty;

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

abstract class Keyframe<T> {
  Duration get duration;
  T compute(TimelineAnimation<T> timeline, int index, double t);
}

class AbsoluteKeyframe<T> implements Keyframe<T> {
  final T from;
  final T to;
  @override
  final Duration duration;

  const AbsoluteKeyframe(
    this.duration,
    this.from,
    this.to,
  );

  @override
  T compute(TimelineAnimation<T> timeline, int index, double t) {
    return timeline.lerp(from, to, t);
  }
}

class RelativeKeyframe<T> implements Keyframe<T> {
  final T target;
  @override
  final Duration duration;

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
    return timeline.lerp(previous, target, t);
  }
}

class StillKeyframe<T> implements Keyframe<T> {
  final T? value;
  @override
  final Duration duration;

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

class TimelineAnimation<T> extends Animatable<T> {
  static T defaultLerp<T>(T a, T b, double t) {
    return ((a as dynamic) + ((b as dynamic) - (a as dynamic)) * t) as T;
  }

  final PropertyLerp<T> lerp;
  final Duration totalDuration;
  final List<Keyframe<T>> keyframes;

  TimelineAnimation._({
    required this.lerp,
    required this.totalDuration,
    required this.keyframes,
  });

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
    return Duration(milliseconds: (t * totalDuration.inMilliseconds).round());
  }

  @override
  T transform(double t) {
    assert(t >= 0 && t <= 1, 'Invalid time');
    assert(keyframes.isNotEmpty, 'No keyframes found');
    var duration = _computeDuration(t);
    Duration current = Duration.zero;
    for (var i = 0; i < keyframes.length; i++) {
      final keyframe = keyframes[i];
      final start = current;
      final end = current + keyframe.duration;
      if (duration <= end) {
        final relative = (duration - start).inMilliseconds /
            keyframe.duration.inMilliseconds;
        return keyframe.compute(this, i, relative);
      }
    }
    // Should never reach here
    throw AssertionError('Invalid time');
  }
}

// void test() {
//   var timeline = TimelineAnimation<double>(keyframes: const [
//     StillKeyframe(0.0, Duration(milliseconds: 100)),
//     AbsoluteKeyframe(4.0, 2.0, Duration(milliseconds: 100)),
//     RelativeKeyframe(8.0, Duration(milliseconds: 100)),
//   ]);
//   AnimationController controller = AnimationController(vsync: null);
//   var animation = controller.drive(timeline);
//   print(animation.value);
// }
