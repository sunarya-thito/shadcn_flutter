import 'package:flutter/widgets.dart';

typedef PropertyLerp<T> = T Function(T a, T b, double t);

class Transformers {
  static PropertyLerp<double> typeDouble = (a, b, t) => a + (b - a) * t;
  static PropertyLerp<int> typeInt = (a, b, t) => (a + (b - a) * t).round();
  static PropertyLerp<Color> typeColor = (a, b, t) => Color.lerp(a, b, t)!;
}

mixin AnimatedMixin on TickerProviderStateMixin {
  List<AnimatedProperty> _animatedProperties = [];
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
