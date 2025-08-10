import 'package:flutter/rendering.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme for [Hidden].
class HiddenTheme {
  /// Direction of the hidden transition.
  final Axis? direction;

  /// Duration of the animation.
  final Duration? duration;

  /// Curve of the animation.
  final Curve? curve;

  /// Whether the widget is reversed.
  final bool? reverse;

  /// Whether to keep cross axis size when hidden.
  final bool? keepCrossAxisSize;

  /// Whether to keep main axis size when hidden.
  final bool? keepMainAxisSize;

  /// Creates a [HiddenTheme].
  const HiddenTheme({
    this.direction,
    this.duration,
    this.curve,
    this.reverse,
    this.keepCrossAxisSize,
    this.keepMainAxisSize,
  });

  /// Returns a copy of this theme with the given fields replaced.
  HiddenTheme copyWith({
    ValueGetter<Axis?>? direction,
    ValueGetter<Duration?>? duration,
    ValueGetter<Curve?>? curve,
    ValueGetter<bool?>? reverse,
    ValueGetter<bool?>? keepCrossAxisSize,
    ValueGetter<bool?>? keepMainAxisSize,
  }) {
    return HiddenTheme(
      direction: direction == null ? this.direction : direction(),
      duration: duration == null ? this.duration : duration(),
      curve: curve == null ? this.curve : curve(),
      reverse: reverse == null ? this.reverse : reverse(),
      keepCrossAxisSize: keepCrossAxisSize == null
          ? this.keepCrossAxisSize
          : keepCrossAxisSize(),
      keepMainAxisSize: keepMainAxisSize == null
          ? this.keepMainAxisSize
          : keepMainAxisSize(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HiddenTheme &&
        other.direction == direction &&
        other.duration == duration &&
        other.curve == curve &&
        other.reverse == reverse &&
        other.keepCrossAxisSize == keepCrossAxisSize &&
        other.keepMainAxisSize == keepMainAxisSize;
  }

  @override
  int get hashCode => Object.hash(
    direction,
    duration,
    curve,
    reverse,
    keepCrossAxisSize,
    keepMainAxisSize,
  );
}

class Hidden extends StatelessWidget {
  final bool hidden;
  final Widget child;
  final Axis? direction;
  final bool? reverse;
  final Duration? duration;
  final Curve? curve;
  final bool? keepCrossAxisSize;
  final bool? keepMainAxisSize;

  const Hidden({
    super.key,
    required this.hidden,
    required this.child,
    this.direction,
    this.duration,
    this.curve,
    this.reverse,
    this.keepCrossAxisSize,
    this.keepMainAxisSize,
  });

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);
    final compTheme = ComponentTheme.maybeOf<HiddenTheme>(context);
    final directionValue = styleValue(
      widgetValue: direction,
      themeValue: compTheme?.direction,
      defaultValue: Axis.horizontal,
    );
    final durationValue = styleValue(
      widgetValue: duration,
      themeValue: compTheme?.duration,
      defaultValue: kDefaultDuration,
    );
    final curveValue = styleValue(
      widgetValue: curve,
      themeValue: compTheme?.curve,
      defaultValue: Curves.easeInOut,
    );
    final reverseValue = styleValue(
      widgetValue: reverse,
      themeValue: compTheme?.reverse,
      defaultValue: false,
    );
    final keepCrossAxisSizeValue = styleValue(
      widgetValue: keepCrossAxisSize,
      themeValue: compTheme?.keepCrossAxisSize,
      defaultValue: false,
    );
    final keepMainAxisSizeValue = styleValue(
      widgetValue: keepMainAxisSize,
      themeValue: compTheme?.keepMainAxisSize,
      defaultValue: false,
    );
    return AnimatedOpacity(
      opacity: hidden ? 0.0 : 1.0,
      duration: durationValue,
      curve: curveValue,
      child: AnimatedValueBuilder(
        value: hidden ? 0.0 : 1.0,
        duration: durationValue,
        curve: curveValue,
        child: child,
        builder: (context, value, child) {
          return _HiddenLayout(
            keepCrossAxisSize: keepCrossAxisSizeValue,
            keepMainAxisSize: keepMainAxisSizeValue,
            textDirection: textDirection,
            direction: directionValue,
            reverse: reverseValue,
            progress: value.clamp(0.0, 1.0),
            child: child,
          );
        },
      ),
    );
  }
}

class _HiddenLayout extends SingleChildRenderObjectWidget {
  final TextDirection textDirection;
  final Axis direction;
  final bool reverse;
  final double progress;
  final bool keepCrossAxisSize;
  final bool keepMainAxisSize;

  const _HiddenLayout({
    required this.textDirection,
    required this.direction,
    required this.reverse,
    required this.progress,
    required this.keepCrossAxisSize,
    required this.keepMainAxisSize,
    super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderHiddenLayout(
      textDirection: textDirection,
      direction: direction,
      reverse: reverse,
      progress: progress,
      keepCrossAxisSize: keepCrossAxisSize,
      keepMainAxisSize: keepMainAxisSize,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderHiddenLayout renderObject,
  ) {
    bool needsLayout = false;
    if (renderObject.textDirection != textDirection) {
      renderObject.textDirection = textDirection;
      needsLayout = true;
    }
    if (renderObject.direction != direction) {
      renderObject.direction = direction;
      needsLayout = true;
    }
    if (renderObject.reverse != reverse) {
      renderObject.reverse = reverse;
      needsLayout = true;
    }
    if (renderObject.progress != progress) {
      renderObject.progress = progress;
      needsLayout = true;
    }
    if (renderObject.keepCrossAxisSize != keepCrossAxisSize) {
      renderObject.keepCrossAxisSize = keepCrossAxisSize;
      needsLayout = true;
    }
    if (renderObject.keepMainAxisSize != keepMainAxisSize) {
      renderObject.keepMainAxisSize = keepMainAxisSize;
      needsLayout = true;
    }
    if (needsLayout) {
      renderObject.markNeedsLayout();
    }
  }
}

class _RenderHiddenLayout extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  TextDirection textDirection;
  Axis direction;
  bool reverse;
  double progress;
  bool keepCrossAxisSize;
  bool keepMainAxisSize;

  _RenderHiddenLayout({
    required this.textDirection,
    required this.direction,
    required this.reverse,
    required this.progress,
    required this.keepCrossAxisSize,
    required this.keepMainAxisSize,
  });

  @override
  double computeMaxIntrinsicHeight(double width) {
    return _computeIntrinsicHeight(
      (RenderBox child, double width) => child.getMaxIntrinsicHeight(width),
      width,
    );
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return _computeIntrinsicWidth(
      (RenderBox child, double height) => child.getMaxIntrinsicWidth(height),
      height,
    );
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return _computeIntrinsicHeight(
      (RenderBox child, double width) => child.getMinIntrinsicHeight(width),
      width,
    );
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return _computeIntrinsicWidth(
      (RenderBox child, double height) => child.getMinIntrinsicWidth(height),
      height,
    );
  }

  double _computeIntrinsicWidth(
    double Function(RenderBox child, double height) childWidth,
    double height,
  ) {
    var child = this.child;
    if (child == null) {
      return 0;
    }
    double width = childWidth(child, height);
    return ((keepMainAxisSize && direction != Axis.vertical) ||
            (keepCrossAxisSize && direction != Axis.horizontal))
        ? width
        : width * progress;
  }

  double _computeIntrinsicHeight(
    double Function(RenderBox child, double width) childHeight,
    double width,
  ) {
    var child = this.child;
    if (child == null) {
      return 0;
    }
    double height = childHeight(child, width);
    return ((keepMainAxisSize && direction != Axis.horizontal) ||
            (keepCrossAxisSize && direction != Axis.vertical))
        ? height
        : height * progress;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    var child = this.child;
    if (child != null) {
      var parentData = child.parentData as BoxParentData;
      return result.addWithPaintOffset(
        offset: parentData.offset,
        position: position,
        hitTest: (result, position) {
          return child.hitTest(result, position: position);
        },
      );
    }
    return false;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    var child = this.child;
    if (child != null) {
      var parentData = child.parentData as BoxParentData;
      context.paintChild(child, offset + parentData.offset);
    }
  }

  @override
  void performLayout() {
    var child = this.child;
    if (child != null) {
      child.layout(constraints, parentUsesSize: true);
      Size childSize = constraints.constrain(child.size);
      double width = childSize.width;
      double height = childSize.height;
      if (!keepMainAxisSize) {
        if (direction == Axis.vertical) {
          height *= progress;
        } else {
          width *= progress;
        }
      }
      if (!keepCrossAxisSize) {
        if (direction == Axis.vertical) {
          width *= progress;
        } else {
          height *= progress;
        }
      }
      Size preferredSize = constraints.constrain(childSize);
      size = constraints.constrain(Size(width, height));
      if (reverse) {
        var parentData = child.parentData as BoxParentData;
        if (direction == Axis.horizontal) {
          parentData.offset = Offset(
            size.width - preferredSize.width,
            -(preferredSize.height - size.height) / 2,
          );
        } else {
          parentData.offset = Offset(
            -(preferredSize.width - size.width) / 2,
            size.height - preferredSize.height,
          );
        }
      } else {
        var parentData = child.parentData as BoxParentData;
        if (direction == Axis.horizontal) {
          parentData.offset = Offset(
            0,
            -(preferredSize.height - size.height) / 2,
          );
        } else {
          parentData.offset = Offset(
            -(preferredSize.width - size.width) / 2,
            0,
          );
        }
      }
    } else {
      size = constraints.biggest;
    }
  }
}
