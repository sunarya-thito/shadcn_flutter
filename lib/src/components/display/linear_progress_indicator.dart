import 'dart:ui' as ui;
import 'dart:ui';

import 'package:shadcn_flutter/shadcn_flutter.dart';

const int _kIndeterminateLinearDuration = 1800;

class LinearProgressIndicator extends StatelessWidget {
  static const Curve _line1Head = Interval(
    0.0,
    750.0 / _kIndeterminateLinearDuration,
    curve: Cubic(0.2, 0.0, 0.8, 1.0),
  );
  static const Curve _line1Tail = Interval(
    333.0 / _kIndeterminateLinearDuration,
    (333.0 + 750.0) / _kIndeterminateLinearDuration,
    curve: Cubic(0.4, 0.0, 1.0, 1.0),
  );
  static const Curve _line2Head = Interval(
    1000.0 / _kIndeterminateLinearDuration,
    (1000.0 + 567.0) / _kIndeterminateLinearDuration,
    curve: Cubic(0.0, 0.0, 0.65, 1.0),
  );
  static const Curve _line2Tail = Interval(
    1267.0 / _kIndeterminateLinearDuration,
    (1267.0 + 533.0) / _kIndeterminateLinearDuration,
    curve: Cubic(0.10, 0.0, 0.45, 1.0),
  );

  final double? value;
  final Color? backgroundColor;
  final double? minHeight;
  final Color? color;
  final BorderRadius? borderRadius;
  final bool showSparks;
  final bool disableAnimation;

  const LinearProgressIndicator({
    super.key,
    this.value,
    this.backgroundColor,
    this.minHeight,
    this.color,
    this.borderRadius,
    this.showSparks = false,
    this.disableAnimation = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final directionality = Directionality.of(context);
    Widget childWidget;
    if (value != null) {
      childWidget = AnimatedValueBuilder(
          value: _LinearProgressIndicatorProperties(
            start: 0,
            end: value!.clamp(0, 1),
            color: color ?? theme.colorScheme.primary,
            backgroundColor:
                backgroundColor ?? theme.colorScheme.primary.scaleAlpha(0.2),
            showSparks: showSparks,
            sparksColor: color ?? theme.colorScheme.primary,
            sparksRadius: theme.scaling * 16,
            textDirection: directionality,
          ),
          duration: disableAnimation ? Duration.zero : kDefaultDuration,
          lerp: _LinearProgressIndicatorProperties.lerp,
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return CustomPaint(
              painter: _LinearProgressIndicatorPainter(
                start: 0,
                end: value.end,
                start2: value.start2,
                end2: value.end2,
                color: value.color,
                backgroundColor: value.backgroundColor,
                showSparks: value.showSparks,
                sparksColor: value.sparksColor,
                sparksRadius: value.sparksRadius,
                textDirection: value.textDirection,
              ),
            );
          });
    } else {
      // indeterminate
      childWidget = RepeatedAnimationBuilder(
        start: 0.0,
        end: 1.0,
        duration: const Duration(milliseconds: _kIndeterminateLinearDuration),
        builder: (context, value, child) {
          double start = _line1Tail.transform(value);
          double end = _line1Head.transform(value);
          double start2 = _line2Tail.transform(value);
          double end2 = _line2Head.transform(value);
          return AnimatedValueBuilder(
              duration: kDefaultDuration,
              lerp: _LinearProgressIndicatorProperties.lerp,
              value: _LinearProgressIndicatorProperties(
                start: start,
                end: end,
                start2: start2,
                end2: end2,
                color: color ?? theme.colorScheme.primary,
                backgroundColor: backgroundColor ??
                    theme.colorScheme.primary.scaleAlpha(0.2),
                showSparks: showSparks,
                sparksColor: color ?? theme.colorScheme.primary,
                sparksRadius: theme.scaling * 16,
                textDirection: directionality,
              ),
              builder: (context, prop, child) {
                return CustomPaint(
                  painter: _LinearProgressIndicatorPainter(
                    // do not animate start and end value
                    start: start,
                    end: end,
                    start2: start2,
                    end2: end2,
                    color: prop.color,
                    backgroundColor: prop.backgroundColor,
                    showSparks: prop.showSparks,
                    sparksColor: prop.sparksColor,
                    sparksRadius: prop.sparksRadius,
                    textDirection: prop.textDirection,
                  ),
                );
              });
        },
      );
    }
    return RepaintBoundary(
      child: SizedBox(
        height: minHeight ?? (theme.scaling * 2),
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.zero,
          child: childWidget,
        ),
      ),
    );
  }
}

class _LinearProgressIndicatorProperties {
  final double start;
  final double end;
  final double? start2;
  final double? end2;
  final Color color;
  final Color backgroundColor;
  final bool showSparks;
  final Color sparksColor;
  final double sparksRadius;
  final TextDirection textDirection;

  const _LinearProgressIndicatorProperties({
    required this.start,
    required this.end,
    this.start2,
    this.end2,
    required this.color,
    required this.backgroundColor,
    required this.showSparks,
    required this.sparksColor,
    required this.sparksRadius,
    required this.textDirection,
  });

  static _LinearProgressIndicatorProperties lerp(
    _LinearProgressIndicatorProperties a,
    _LinearProgressIndicatorProperties b,
    double t,
  ) {
    return _LinearProgressIndicatorProperties(
      start: _lerpDouble(a.start, b.start, t)!,
      end: _lerpDouble(a.end, b.end, t)!,
      start2: _lerpDouble(a.start2, b.start2, t),
      end2: _lerpDouble(a.end2, b.end2, t),
      color: Color.lerp(a.color, b.color, t)!,
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t)!,
      showSparks: b.showSparks,
      sparksColor: Color.lerp(a.sparksColor, b.sparksColor, t)!,
      sparksRadius: _lerpDouble(a.sparksRadius, b.sparksRadius, t)!,
      textDirection: b.textDirection,
    );
  }
}

double? _lerpDouble(double? a, double? b, double t) {
  if (a == null && b == null) {
    return null;
  }
  if (a!.isNaN || b!.isNaN) {
    return double.nan;
  }
  return a + (b - a) * t;
}

class _LinearProgressIndicatorPainter extends CustomPainter {
  static final gradientTransform =
      (Matrix4.identity()..scale(1.0, 0.5)).storage;

  final double start;
  final double end;
  final double? start2; // for indeterminate
  final double? end2;
  final Color color;
  final Color backgroundColor;
  final bool showSparks;
  final Color sparksColor;
  final double sparksRadius;
  final TextDirection textDirection;

  _LinearProgressIndicatorPainter({
    required this.start,
    required this.end,
    this.start2,
    this.end2,
    required this.color,
    required this.backgroundColor,
    required this.showSparks,
    required this.sparksColor,
    required this.sparksRadius,
    this.textDirection = TextDirection.ltr,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var start = this.start;
    var end = this.end;
    var start2 = this.start2;
    var end2 = this.end2;
    if (textDirection == TextDirection.rtl) {
      start = 1 - end;
      end = 1 - this.start;
      if (start2 != null && end2 != null) {
        start2 = 1 - end2;
        end2 = 1 - this.start2!;
      }
    }

    if (start.isNaN) {
      start = 0;
    }
    if (end.isNaN) {
      end = 0;
    }
    if (start2 != null && start2.isNaN) {
      start2 = 0;
    }
    if (end2 != null && end2.isNaN) {
      end2 = 0;
    }

    final paint = Paint()..style = PaintingStyle.fill;

    paint.color = backgroundColor;

    canvas.drawRRect(
      RRect.fromLTRBR(
          0, 0, size.width, size.height, Radius.circular(size.height / 2)),
      paint,
    );

    paint.color = color;
    var rectValue = Rect.fromLTWH(
      size.width * start,
      0,
      size.width * (end - start),
      size.height,
    );
    canvas.drawRect(rectValue, paint);
    if (start2 != null && end2 != null) {
      rectValue = Rect.fromLTWH(
        size.width * start2,
        0,
        size.width * (end2 - start2),
        size.height,
      );
      canvas.drawRect(rectValue, paint);
    }

    if (showSparks) {
      // use RadialGradient to create sparks

      final gradient = ui.Gradient.radial(
        // colors: [sparksColor, Colors.transparent],
        // stops: const [0.0, 1.0],
        Offset(size.width * (end - start), size.height / 2),
        sparksRadius,
        [
          sparksColor,
          sparksColor.withAlpha(0),
        ],
        [0.0, 1.0],
        ui.TileMode.clamp,
        // scale to make oval
        gradientTransform,
      );
      paint.shader = gradient;
      canvas.drawCircle(
        Offset(size.width * (end - start), size.height / 2),
        sparksRadius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _LinearProgressIndicatorPainter oldDelegate) {
    return oldDelegate.start != start ||
        oldDelegate.end != end ||
        oldDelegate.color != color ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.showSparks != showSparks ||
        oldDelegate.sparksColor != sparksColor ||
        oldDelegate.sparksRadius != sparksRadius ||
        oldDelegate.textDirection != textDirection ||
        oldDelegate.start2 != start2 ||
        oldDelegate.end2 != end2;
  }
}
