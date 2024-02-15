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
