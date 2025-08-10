import 'dart:ui';

import '../../../shadcn_flutter.dart';

class SurfaceBlur extends StatefulWidget {
  final Widget child;
  final double? surfaceBlur;
  final BorderRadiusGeometry? borderRadius;

  const SurfaceBlur({
    super.key,
    required this.child,
    this.surfaceBlur,
    this.borderRadius,
  });

  @override
  State<SurfaceBlur> createState() => _SurfaceBlurState();
}

class _SurfaceBlurState extends State<SurfaceBlur> {
  final GlobalKey _mainContainerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    if (widget.surfaceBlur == null || widget.surfaceBlur! <= 0) {
      return KeyedSubtree(key: _mainContainerKey, child: widget.child);
    }
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: widget.borderRadius ?? BorderRadius.zero,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: widget.surfaceBlur!,
                sigmaY: widget.surfaceBlur!,
              ),
              // had to add SizedBox, otherwise it won't blur
              child: const SizedBox(),
            ),
          ),
        ),
        KeyedSubtree(key: _mainContainerKey, child: widget.child),
      ],
    );
  }
}

class OutlinedContainerTheme {
  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;
  final BorderStyle? borderStyle;
  final double? borderWidth;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? padding;
  final double? surfaceOpacity;
  final double? surfaceBlur;

  const OutlinedContainerTheme({
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.borderStyle,
    this.borderWidth,
    this.boxShadow,
    this.padding,
    this.surfaceOpacity,
    this.surfaceBlur,
  });

  OutlinedContainerTheme copyWith({
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<Color?>? borderColor,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<BorderStyle?>? borderStyle,
    ValueGetter<double?>? borderWidth,
    ValueGetter<List<BoxShadow>?>? boxShadow,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<double?>? surfaceOpacity,
    ValueGetter<double?>? surfaceBlur,
  }) {
    return OutlinedContainerTheme(
      backgroundColor: backgroundColor == null
          ? this.backgroundColor
          : backgroundColor(),
      borderColor: borderColor == null ? this.borderColor : borderColor(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      borderStyle: borderStyle == null ? this.borderStyle : borderStyle(),
      borderWidth: borderWidth == null ? this.borderWidth : borderWidth(),
      boxShadow: boxShadow == null ? this.boxShadow : boxShadow(),
      padding: padding == null ? this.padding : padding(),
      surfaceOpacity: surfaceOpacity == null
          ? this.surfaceOpacity
          : surfaceOpacity(),
      surfaceBlur: surfaceBlur == null ? this.surfaceBlur : surfaceBlur(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OutlinedContainerTheme &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor &&
        other.borderRadius == borderRadius &&
        other.borderStyle == borderStyle &&
        other.borderWidth == borderWidth &&
        other.boxShadow == boxShadow &&
        other.padding == padding &&
        other.surfaceOpacity == surfaceOpacity &&
        other.surfaceBlur == surfaceBlur;
  }

  @override
  int get hashCode => Object.hash(
    backgroundColor,
    borderColor,
    borderRadius,
    borderStyle,
    borderWidth,
    boxShadow,
    padding,
    surfaceOpacity,
    surfaceBlur,
  );
}

class OutlinedContainer extends StatefulWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final Clip clipBehavior;
  final BorderRadiusGeometry? borderRadius;
  final BorderStyle? borderStyle;
  final double? borderWidth;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? padding;
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final double? width;
  final double? height;
  final Duration? duration;
  const OutlinedContainer({
    super.key,
    required this.child,
    this.borderColor,
    this.backgroundColor,
    this.clipBehavior = Clip.antiAlias,
    this.borderRadius,
    this.borderStyle,
    this.borderWidth,
    this.boxShadow,
    this.padding,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.width,
    this.height,
    this.duration,
  });

  @override
  State<OutlinedContainer> createState() => _OutlinedContainerState();
}

class _OutlinedContainerState extends State<OutlinedContainer> {
  final GlobalKey _mainContainerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<OutlinedContainerTheme>(context);
    var borderRadius = styleValue(
      defaultValue: theme.borderRadiusXl,
      themeValue: compTheme?.borderRadius,
      widgetValue: widget.borderRadius,
    ).resolve(Directionality.of(context));
    var backgroundColor = styleValue(
      defaultValue: theme.colorScheme.background,
      themeValue: compTheme?.backgroundColor,
      widgetValue: widget.backgroundColor,
    );
    final double? surfaceOpacity = styleValue(
      themeValue: compTheme?.surfaceOpacity,
      widgetValue: widget.surfaceOpacity,
    );
    if (surfaceOpacity != null) {
      backgroundColor = backgroundColor.scaleAlpha(surfaceOpacity);
    }
    final borderColor = styleValue(
      defaultValue: theme.colorScheme.muted,
      themeValue: compTheme?.borderColor,
      widgetValue: widget.borderColor,
    );
    final borderWidth = styleValue(
      defaultValue: 1 * scaling,
      themeValue: compTheme?.borderWidth,
      widgetValue: widget.borderWidth,
    );
    final borderStyle = styleValue<BorderStyle>(
      defaultValue: BorderStyle.solid,
      themeValue: compTheme?.borderStyle,
      widgetValue: widget.borderStyle,
    );
    final boxShadow = styleValue<List<BoxShadow>>(
      themeValue: compTheme?.boxShadow,
      widgetValue: widget.boxShadow,
    );
    final padding = styleValue<EdgeInsetsGeometry>(
      themeValue: compTheme?.padding,
      widgetValue: widget.padding,
    );
    final surfaceBlur = styleValue<double>(
      themeValue: compTheme?.surfaceBlur,
      widgetValue: widget.surfaceBlur,
    );
    Widget childWidget = AnimatedContainer(
      duration: widget.duration ?? Duration.zero,
      key: _mainContainerKey,
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
          style: borderStyle,
        ),
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      child: AnimatedContainer(
        duration: widget.duration ?? Duration.zero,
        padding: padding,
        clipBehavior: widget.clipBehavior,
        decoration: BoxDecoration(
          borderRadius: subtractByBorder(borderRadius, borderWidth),
        ),
        child: widget.child,
      ),
    );
    if (surfaceBlur != null && surfaceBlur > 0) {
      childWidget = SurfaceBlur(
        surfaceBlur: surfaceBlur,
        borderRadius: subtractByBorder(borderRadius, borderWidth),
        child: childWidget,
      );
    }
    return childWidget;
  }
}

class DashedLineProperties {
  final double width;
  final double gap;
  final double thickness;
  final Color color;

  const DashedLineProperties({
    required this.width,
    required this.gap,
    required this.thickness,
    required this.color,
  });

  static DashedLineProperties lerp(
    DashedLineProperties a,
    DashedLineProperties b,
    double t,
  ) {
    return DashedLineProperties(
      width: lerpDouble(a.width, b.width, t)!,
      gap: lerpDouble(a.gap, b.gap, t)!,
      thickness: lerpDouble(a.thickness, b.thickness, t)!,
      color: Color.lerp(a.color, b.color, t)!,
    );
  }
}

class DashedLine extends StatelessWidget {
  final double? width;
  final double? gap;
  final double? thickness;
  final Color? color;

  const DashedLine({
    super.key,
    this.width,
    this.gap,
    this.thickness,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return AnimatedValueBuilder(
      value: DashedLineProperties(
        width: width ?? (8 * scaling),
        gap: gap ?? (5 * scaling),
        thickness: thickness ?? (1 * scaling),
        color: color ?? theme.colorScheme.border,
      ),
      duration: kDefaultDuration,
      lerp: DashedLineProperties.lerp,
      builder: (context, value, child) {
        return CustomPaint(
          painter: DashedLinePainter(
            width: value.width,
            gap: value.gap,
            thickness: value.thickness,
            color: value.color,
          ),
        );
      },
    );
  }
}

class DashedContainerProperties {
  final double width;
  final double gap;
  final double thickness;
  final Color color;
  final BorderRadiusGeometry borderRadius;

  const DashedContainerProperties({
    required this.width,
    required this.gap,
    required this.thickness,
    required this.color,
    required this.borderRadius,
  });

  static DashedContainerProperties lerp(
    BuildContext context,
    DashedContainerProperties a,
    DashedContainerProperties b,
    double t,
  ) {
    return DashedContainerProperties(
      width: lerpDouble(a.width, b.width, t)!,
      gap: lerpDouble(a.gap, b.gap, t)!,
      thickness: lerpDouble(a.thickness, b.thickness, t)!,
      color: Color.lerp(a.color, b.color, t)!,
      borderRadius: BorderRadius.lerp(
        a.borderRadius.optionallyResolve(context),
        b.borderRadius.optionallyResolve(context),
        t,
      )!,
    );
  }
}

class DashedContainer extends StatelessWidget {
  final double? strokeWidth;
  final double? gap;
  final double? thickness;
  final Color? color;
  final Widget child;
  final BorderRadiusGeometry? borderRadius;

  const DashedContainer({
    super.key,
    this.strokeWidth,
    this.gap,
    this.thickness,
    this.color,
    required this.child,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedValueBuilder(
      value: DashedContainerProperties(
        width: strokeWidth ?? (8 * theme.scaling),
        gap: gap ?? (5 * theme.scaling),
        thickness: thickness ?? (1 * theme.scaling),
        color: color ?? theme.colorScheme.border,
        borderRadius: borderRadius ?? theme.borderRadiusLg,
      ),
      duration: kDefaultDuration,
      lerp: (a, b, t) {
        return DashedContainerProperties.lerp(context, a, b, t);
      },
      builder: (context, value, child) {
        return CustomPaint(
          painter: DashedPainter(
            width: value.width,
            gap: value.gap,
            thickness: value.thickness,
            color: value.color,
            borderRadius: value.borderRadius.optionallyResolve(context),
          ),
          child: child,
        );
      },
      child: child,
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final double width;
  final double gap;
  final double thickness;
  final Color color;

  DashedLinePainter({
    required this.width,
    required this.gap,
    required this.thickness,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    PathMetrics pathMetrics = path.computeMetrics();
    Path draw = Path();
    for (PathMetric pathMetric in pathMetrics) {
      for (double i = 0; i < pathMetric.length; i += gap + width) {
        double start = i;
        double end = i + width;
        if (end > pathMetric.length) {
          end = pathMetric.length;
        }
        draw.addPath(pathMetric.extractPath(start, end), Offset.zero);
      }
    }
    canvas.drawPath(
      draw,
      Paint()
        ..color = color
        ..strokeWidth = thickness
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant DashedLinePainter oldDelegate) {
    return oldDelegate.width != width ||
        oldDelegate.gap != gap ||
        oldDelegate.thickness != thickness ||
        oldDelegate.color != color;
  }
}

class DashedPainter extends CustomPainter {
  final double width;
  final double gap;
  final double thickness;
  final Color color;
  final BorderRadius? borderRadius;

  DashedPainter({
    required this.width,
    required this.gap,
    required this.thickness,
    required this.color,
    this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    if (borderRadius != null && borderRadius != BorderRadius.zero) {
      path.addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0, 0, size.width, size.height),
          topLeft: borderRadius!.topLeft,
          topRight: borderRadius!.topRight,
          bottomLeft: borderRadius!.bottomLeft,
          bottomRight: borderRadius!.bottomRight,
        ),
      );
    } else {
      path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    }

    PathMetrics pathMetrics = path.computeMetrics();
    Path draw = Path();
    for (PathMetric pathMetric in pathMetrics) {
      for (double i = 0; i < pathMetric.length; i += gap + width) {
        double start = i;
        double end = i + width;
        if (end > pathMetric.length) {
          end = pathMetric.length;
        }
        draw.addPath(pathMetric.extractPath(start, end), Offset.zero);
      }
    }
    canvas.drawPath(
      draw,
      Paint()
        ..color = color
        ..strokeWidth = thickness
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant DashedPainter oldDelegate) {
    return oldDelegate.width != width ||
        oldDelegate.gap != gap ||
        oldDelegate.thickness != thickness ||
        oldDelegate.color != color ||
        oldDelegate.borderRadius != borderRadius;
  }
}
