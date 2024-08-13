import 'package:flutter/rendering.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class OverflowMarquee extends StatelessWidget {
  final Widget child;
  final Axis direction;
  final Duration duration;
  final Duration delayDuration;
  final double fadePortion;

  const OverflowMarquee({
    super.key,
    required this.child,
    this.direction = Axis.horizontal,
    this.duration = const Duration(seconds: 2),
    this.delayDuration = const Duration(milliseconds: 500),
    this.fadePortion = 25,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: RepeatedAnimationBuilder(
        start: 0.0,
        end: 1.0,
        curve: IntervalDuration.delayed(
          duration: duration,
          startDelay: delayDuration,
        ),
        duration: duration + delayDuration * 2,
        mode: RepeatMode.pingPong,
        builder: (context, value, child) {
          return _OverflowMarqueeLayout(
            direction: direction,
            progress: value,
            fadePortion: fadePortion,
            duration: duration,
            delayDuration: delayDuration,
            child: this.child,
          );
        },
      ),
    );
  }
}

class _OverflowMarqueeLayout extends SingleChildRenderObjectWidget {
  final Axis direction;
  final double progress;
  final double fadePortion;
  final Duration duration;
  final Duration delayDuration;

  _OverflowMarqueeLayout({
    required this.direction,
    required this.progress,
    this.fadePortion = 25,
    required this.duration,
    required this.delayDuration,
    required Widget child,
  }) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderOverflowMarqueeLayout(
      null,
      direction: direction,
      progress: progress,
      fadePortion: fadePortion,
      duration: duration,
      delayDuration: delayDuration,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderOverflowMarqueeLayout renderObject) {
    bool hasChanged = false;
    if (renderObject._direction != direction) {
      renderObject._direction = direction;
      hasChanged = true;
    }
    if (renderObject._progress != progress) {
      renderObject._progress = progress;
      hasChanged = true;
    }
    if (renderObject._fadePortion != fadePortion) {
      renderObject._fadePortion = fadePortion;
      hasChanged = true;
    }
    if (renderObject._duration != duration) {
      renderObject._duration = duration;
      hasChanged = true;
    }
    if (renderObject._delayDuration != delayDuration) {
      renderObject._delayDuration = delayDuration;
      hasChanged = true;
    }
    if (hasChanged) {
      renderObject.markNeedsLayout();
    }
  }
}

class _OverflowMarqueeParentData extends ContainerBoxParentData<RenderBox> {
  double? sizeDiff;
}

class _RenderOverflowMarqueeLayout extends RenderShiftedBox
    with ContainerRenderObjectMixin<RenderBox, _OverflowMarqueeParentData> {
  Axis _direction;
  double _progress;
  double _fadePortion;
  Duration _duration;
  Duration _delayDuration;

  _RenderOverflowMarqueeLayout(
    super.child, {
    required Axis direction,
    required double progress,
    required double fadePortion,
    required Duration duration,
    required Duration delayDuration,
  })  : _direction = direction,
        _progress = progress,
        _fadePortion = fadePortion,
        _duration = duration,
        _delayDuration = delayDuration;

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _OverflowMarqueeParentData) {
      child.parentData = _OverflowMarqueeParentData();
    }
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (_direction == Axis.horizontal) {
      return super.computeMaxIntrinsicHeight(double.infinity);
    }
    return super.computeMaxIntrinsicHeight(width);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    if (_direction == Axis.vertical) {
      return super.computeMaxIntrinsicWidth(double.infinity);
    }
    return super.computeMaxIntrinsicWidth(height);
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    if (_direction == Axis.horizontal) {
      return super.computeMinIntrinsicHeight(double.infinity);
    }
    return super.computeMinIntrinsicHeight(width);
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    if (_direction == Axis.vertical) {
      return super.computeMinIntrinsicWidth(double.infinity);
    }
    return super.computeMinIntrinsicWidth(height);
  }

  @override
  Size computeDryLayout(covariant BoxConstraints constraints) {
    if (_direction == Axis.horizontal) {
      constraints = constraints.copyWith(
        maxWidth: double.infinity,
      );
    } else {
      constraints = constraints.copyWith(
        maxHeight: double.infinity,
      );
    }
    final child = this.child;
    if (child != null) {
      return child.getDryLayout(constraints);
    }
    return constraints.biggest;
  }

  @override
  ShaderMaskLayer? get layer => super.layer as ShaderMaskLayer?;

  @override
  bool get alwaysNeedsCompositing => child != null;

  double get offsetProgress {
    // var durationInMicros = _duration.inMicroseconds;
    // durationInMicros += _delayDuration.inMicroseconds * 2;
    // double begin = _delayDuration.inMicroseconds / durationInMicros;
    // double end = 1 - begin;
    // return ((_progress - begin) / (end - begin)).clamp(0, 1);
    return _progress;
  }

  double? get sizeDiff {
    final parentData = child?.parentData as _OverflowMarqueeParentData?;
    return parentData?.sizeDiff;
  }

  double get fadeStartProgress {
    final child = this.child;
    if (child != null) {
      double size = sizeDiff ?? 0;
      double progressedSize = size * offsetProgress;
      return (progressedSize / _fadePortion).clamp(0, 1);
    }
    return 0;
  }

  double get fadeEndProgress {
    final child = this.child;
    if (child != null) {
      double size = sizeDiff ?? 0;
      double progressedSize = size * (1 - offsetProgress);
      return (progressedSize / _fadePortion).clamp(0, 1);
    }
    return 0;
  }

  Shader? _createAlphaShader(
      bool fadeStart, bool fadeEnd, Rect bounds, double fadePortion) {
    double portionSize;
    if (_direction == Axis.horizontal) {
      portionSize = fadePortion / bounds.width;
    } else {
      portionSize = fadePortion / bounds.height;
    }
    List<Color> colors = [];
    List<double> stops = [];
    if (fadeStart) {
      double start = fadeStartProgress;
      Color startColor = Colors.white.withOpacity(1 - start);
      colors.addAll([startColor, Colors.white]);
      stops.addAll([0.0, portionSize]);
    } else {
      colors.addAll([Colors.white]);
      stops.addAll([0.0]);
    }
    if (fadeEnd) {
      double end = fadeEndProgress;
      Color endColor = Colors.white.withOpacity(1 - end);
      colors.addAll([Colors.white, endColor]);
      stops.addAll([1.0 - portionSize, 1.0]);
    } else {
      colors.addAll([Colors.white]);
      stops.addAll([1.0]);
    }
    Alignment begin;
    Alignment end;
    if (_direction == Axis.horizontal) {
      begin = Alignment.centerLeft;
      end = Alignment.centerRight;
    } else {
      begin = Alignment.topCenter;
      end = Alignment.bottomCenter;
    }
    return LinearGradient(
      begin: begin,
      end: end,
      colors: colors,
      stops: stops,
    ).createShader(bounds);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      layer ??= ShaderMaskLayer();
      final parentData = child!.parentData as _OverflowMarqueeParentData;
      final sizeDiff = parentData.sizeDiff ?? 0;
      var progress = offsetProgress;
      Shader? shader = _createAlphaShader(
        progress > 0 && sizeDiff != 0,
        progress < 1 && sizeDiff != 0,
        Offset.zero & size,
        25,
      );
      if (shader != null) {
        assert(needsCompositing);
        layer!
          ..shader = shader
          ..maskRect = offset & size
          ..blendMode = BlendMode.modulate;
        context.pushLayer(layer!, super.paint, offset);
        assert(() {
          layer!.debugCreator = debugCreator;
          return true;
        }());
      } else {
        layer = null;
        super.paint(context, offset + parentData.offset);
      }
    } else {
      layer = null;
    }
  }

  @override
  void performLayout() {
    var child = this.child;
    if (child != null) {
      var constraints = this.constraints;
      if (_direction == Axis.horizontal) {
        constraints = constraints.copyWith(
          maxWidth: double.infinity,
        );
      } else {
        constraints = constraints.copyWith(
          maxHeight: double.infinity,
        );
      }
      child.layout(constraints, parentUsesSize: true);
      size = this.constraints.constrain(child.size);
      final sizeDiff = child.size.width - size.width;
      var progress = offsetProgress;
      final offset = _direction == Axis.horizontal
          ? Offset(-sizeDiff * progress, 0)
          : Offset(0, -sizeDiff * progress);
      final parentData = child.parentData as _OverflowMarqueeParentData;
      parentData.sizeDiff = sizeDiff;
      parentData.offset = offset;
    } else {
      size = constraints.biggest;
    }
  }
}
