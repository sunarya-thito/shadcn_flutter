import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart'
    show RenderSliver, SliverGeometry, RenderFlex;
import 'package:pixel_snap/pixel_snap.dart' as pixel_snap;
import 'package:pixel_snap/src/forked/render_flex.dart'
    as pixel_snap_render_flex;

import '../../../shadcn_flutter.dart';

/*
 * The following code is a fork of the gap package.
 * The original package can be found at https://pub.dev/packages/gap
 * The forked code has been modified to support pixel snapping.
 */

/// A widget that takes a fixed amount of space in the direction of its parent.
///
/// It only works in the following cases:
/// - It is a descendant of a [Row], [Column], or [Flex],
/// and the path from the [Gap] widget to its enclosing [Row], [Column], or
/// [Flex] must contain only [StatelessWidget]s or [StatefulWidget]s (not other
/// kinds of widgets, like [RenderObjectWidget]s).
/// - It is a descendant of a [Scrollable].
///
/// See also:
///
///  * [MaxGap], a gap that can take, at most, the amount of space specified.
///  * [SliverGap], the sliver version of this widget.
class Gap extends StatelessWidget {
  /// Creates a widget that takes a fixed [mainAxisExtent] of space in the
  /// direction of its parent.
  ///
  /// The [mainAxisExtent] must not be null and must be positive.
  /// The [crossAxisExtent] must be either null or positive.
  const Gap(
    this.mainAxisExtent, {
    super.key,
    this.crossAxisExtent,
    this.color,
  })  : assert(mainAxisExtent >= 0 && mainAxisExtent < double.infinity),
        assert(crossAxisExtent == null || crossAxisExtent >= 0);

  /// Creates a widget that takes a fixed [mainAxisExtent] of space in the
  /// direction of its parent and expands in the cross axis direction.
  ///
  /// The [mainAxisExtent] must not be null and must be positive.
  const Gap.expand(
    double mainAxisExtent, {
    Key? key,
    Color? color,
  }) : this(
          mainAxisExtent,
          key: key,
          crossAxisExtent: double.infinity,
          color: color,
        );

  /// The amount of space this widget takes in the direction of its parent.
  ///
  /// For example:
  /// - If the parent is a [Column] this is the height of this widget.
  /// - If the parent is a [Row] this is the width of this widget.
  ///
  /// Must not be null and must be positive.
  final double mainAxisExtent;

  /// The amount of space this widget takes in the opposite direction of the
  /// parent.
  ///
  /// For example:
  /// - If the parent is a [Column] this is the width of this widget.
  /// - If the parent is a [Row] this is the height of this widget.
  ///
  /// Must be positive or null. If it's null (the default) the cross axis extent
  /// will be the same as the constraints of the parent in the opposite
  /// direction.
  final double? crossAxisExtent;

  /// The color used to fill the gap.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final scrollableState = Scrollable.maybeOf(context);
    final AxisDirection? axisDirection = scrollableState?.axisDirection;
    final Axis? fallbackDirection =
        axisDirection == null ? null : axisDirectionToAxis(axisDirection);

    return _RawGap(
      mainAxisExtent,
      crossAxisExtent: crossAxisExtent,
      color: color,
      fallbackDirection: fallbackDirection,
    );
  }
}

/// A widget that takes, at most, an amount of space in a [Row], [Column],
/// or [Flex] widget.
///
/// A [MaxGap] widget must be a descendant of a [Row], [Column], or [Flex],
/// and the path from the [MaxGap] widget to its enclosing [Row], [Column], or
/// [Flex] must contain only [StatelessWidget]s or [StatefulWidget]s (not other
/// kinds of widgets, like [RenderObjectWidget]s).
///
/// See also:
///
///  * [Gap], the unflexible version of this widget.
class MaxGap extends StatelessWidget {
  /// Creates a widget that takes, at most, the specified [mainAxisExtent] of
  /// space in a [Row], [Column], or [Flex] widget.
  ///
  /// The [mainAxisExtent] must not be null and must be positive.
  /// The [crossAxisExtent] must be either null or positive.
  const MaxGap(
    this.mainAxisExtent, {
    super.key,
    this.crossAxisExtent,
    this.color,
  });

  /// Creates a widget that takes, at most, the specified [mainAxisExtent] of
  /// space in a [Row], [Column], or [Flex] widget and expands in the cross axis
  /// direction.
  ///
  /// The [mainAxisExtent] must not be null and must be positive.
  /// The [crossAxisExtent] must be either null or positive.
  const MaxGap.expand(
    double mainAxisExtent, {
    Key? key,
    Color? color,
  }) : this(
          mainAxisExtent,
          key: key,
          crossAxisExtent: double.infinity,
          color: color,
        );

  /// The amount of space this widget takes in the direction of the parent.
  ///
  /// If the parent is a [Column] this is the height of this widget.
  /// If the parent is a [Row] this is the width of this widget.
  ///
  /// Must not be null and must be positive.
  final double mainAxisExtent;

  /// The amount of space this widget takes in the opposite direction of the
  /// parent.
  ///
  /// If the parent is a [Column] this is the width of this widget.
  /// If the parent is a [Row] this is the height of this widget.
  ///
  /// Must be positive or null. If it's null (the default) the cross axis extent
  /// will be the same as the constraints of the parent in the opposite
  /// direction.
  final double? crossAxisExtent;

  /// The color used to fill the gap.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: _RawGap(
        mainAxisExtent,
        crossAxisExtent: crossAxisExtent,
        color: color,
      ),
    );
  }
}

class _RawGap extends LeafRenderObjectWidget {
  const _RawGap(
    this.mainAxisExtent, {
    this.crossAxisExtent,
    this.color,
    this.fallbackDirection,
  })  : assert(mainAxisExtent >= 0 && mainAxisExtent < double.infinity),
        assert(crossAxisExtent == null || crossAxisExtent >= 0);

  final double mainAxisExtent;

  final double? crossAxisExtent;

  final Color? color;

  final Axis? fallbackDirection;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderGap(
      mainAxisExtent: mainAxisExtent,
      crossAxisExtent: crossAxisExtent ?? 0,
      color: color,
      fallbackDirection: fallbackDirection,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderGap renderObject) {
    renderObject
      ..mainAxisExtent = mainAxisExtent
      ..crossAxisExtent = crossAxisExtent ?? 0
      ..color = color
      ..fallbackDirection = fallbackDirection;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('mainAxisExtent', mainAxisExtent));
    properties.add(
        DoubleProperty('crossAxisExtent', crossAxisExtent, defaultValue: 0));
    properties.add(ColorProperty('color', color));
    properties.add(EnumProperty<Axis>('fallbackDirection', fallbackDirection));
  }
}

class RenderGap extends RenderBox {
  RenderGap({
    required double mainAxisExtent,
    double? crossAxisExtent,
    Axis? fallbackDirection,
    Color? color,
  })  : _mainAxisExtent = mainAxisExtent,
        _crossAxisExtent = crossAxisExtent,
        _color = color,
        _fallbackDirection = fallbackDirection;

  double get mainAxisExtent => _mainAxisExtent;
  double _mainAxisExtent;
  set mainAxisExtent(double value) {
    if (_mainAxisExtent != value) {
      _mainAxisExtent = value;
      markNeedsLayout();
    }
  }

  double? get crossAxisExtent => _crossAxisExtent;
  double? _crossAxisExtent;
  set crossAxisExtent(double? value) {
    if (_crossAxisExtent != value) {
      _crossAxisExtent = value;
      markNeedsLayout();
    }
  }

  Axis? get fallbackDirection => _fallbackDirection;
  Axis? _fallbackDirection;
  set fallbackDirection(Axis? value) {
    if (_fallbackDirection != value) {
      _fallbackDirection = value;
      markNeedsLayout();
    }
  }

  Axis? get _direction {
    final parentNode = parent;
    if (parentNode is pixel_snap_render_flex.RenderFlex) {
      return parentNode.direction;
    } else if (parentNode is RenderFlex) {
      return parentNode.direction;
    } else {
      return fallbackDirection;
    }
  }

  Color? get color => _color;
  Color? _color;
  set color(Color? value) {
    if (_color != value) {
      _color = value;
      markNeedsPaint();
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return _computeIntrinsicExtent(
      Axis.horizontal,
      () => super.computeMinIntrinsicWidth(height),
    )!;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return _computeIntrinsicExtent(
      Axis.horizontal,
      () => super.computeMaxIntrinsicWidth(height),
    )!;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return _computeIntrinsicExtent(
      Axis.vertical,
      () => super.computeMinIntrinsicHeight(width),
    )!;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return _computeIntrinsicExtent(
      Axis.vertical,
      () => super.computeMaxIntrinsicHeight(width),
    )!;
  }

  double? _computeIntrinsicExtent(Axis axis, double Function() compute) {
    final Axis? direction = _direction;
    if (direction == axis) {
      return _mainAxisExtent;
    } else {
      if (_crossAxisExtent!.isFinite) {
        return _crossAxisExtent;
      } else {
        return compute();
      }
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final Axis? direction = _direction;

    if (direction != null) {
      if (direction == Axis.horizontal) {
        return constraints.constrain(Size(mainAxisExtent, crossAxisExtent!));
      } else {
        return constraints.constrain(Size(crossAxisExtent!, mainAxisExtent));
      }
    } else {
      throw FlutterError(
        'A Gap widget must be placed directly inside a Flex widget '
        'or its fallbackDirection must not be null',
      );
    }
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (color != null) {
      final Paint paint = Paint()..color = color!;
      context.canvas.drawRect(offset & size, paint);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('mainAxisExtent', mainAxisExtent));
    properties.add(DoubleProperty('crossAxisExtent', crossAxisExtent));
    properties.add(ColorProperty('color', color));
    properties.add(EnumProperty<Axis>('fallbackDirection', fallbackDirection));
  }
}

/// A sliver that takes a fixed amount of space.
///
/// See also:
///
///  * [Gap], the render box version of this widget.
class SliverGap extends LeafRenderObjectWidget {
  /// Creates a sliver that takes a fixed [mainAxisExtent] of space.
  ///
  /// The [mainAxisExtent] must not be null and must be positive.
  const SliverGap(
    this.mainAxisExtent, {
    super.key,
    this.color,
  }) : assert(mainAxisExtent >= 0 && mainAxisExtent < double.infinity);

  /// The amount of space this widget takes in the direction of the parent.
  ///
  /// Must not be null and must be positive.
  final double mainAxisExtent;

  /// The color used to fill the gap.
  final Color? color;

  @override
  RenderObject createRenderObject(BuildContext context) {
    final ps = pixel_snap.PixelSnap.of(context);
    return RenderSliverGap(
      mainAxisExtent: mainAxisExtent.pixelSnap(ps),
      color: color,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderSliverGap renderObject) {
    final ps = pixel_snap.PixelSnap.of(context);
    renderObject
      ..mainAxisExtent = mainAxisExtent.pixelSnap(ps)
      ..color = color;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('mainAxisExtent', mainAxisExtent));
    properties.add(ColorProperty('color', color));
  }
}

class RenderSliverGap extends RenderSliver {
  RenderSliverGap({
    required double mainAxisExtent,
    Color? color,
  })  : _mainAxisExtent = mainAxisExtent,
        _color = color;

  double get mainAxisExtent => _mainAxisExtent;
  double _mainAxisExtent;
  set mainAxisExtent(double value) {
    if (_mainAxisExtent != value) {
      _mainAxisExtent = value;
      markNeedsLayout();
    }
  }

  Color? get color => _color;
  Color? _color;
  set color(Color? value) {
    if (_color != value) {
      _color = value;
      markNeedsPaint();
    }
  }

  @override
  void performLayout() {
    final double paintExtent = calculatePaintOffset(
      constraints,
      from: 0,
      to: mainAxisExtent,
    );
    final double cacheExtent = calculateCacheOffset(
      constraints,
      from: 0,
      to: mainAxisExtent,
    );

    assert(paintExtent.isFinite);
    assert(paintExtent >= 0.0);
    geometry = SliverGeometry(
      scrollExtent: mainAxisExtent,
      paintExtent: paintExtent,
      cacheExtent: cacheExtent,
      maxPaintExtent: mainAxisExtent,
      hitTestExtent: paintExtent,
      hasVisualOverflow: mainAxisExtent > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0.0,
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (color != null) {
      final Paint paint = Paint()..color = color!;
      final Size size = constraints
          .asBoxConstraints(
            minExtent: geometry!.paintExtent,
            maxExtent: geometry!.paintExtent,
          )
          .constrain(Size.zero);
      context.canvas.drawRect(offset & size, paint);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('mainAxisExtent', mainAxisExtent));
    properties.add(ColorProperty('color', color));
  }
}
