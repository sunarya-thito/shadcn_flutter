import 'dart:ui';

import '../../shadcn_flutter.dart';

class OutlinedContainer extends StatefulWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final Clip clipBehavior;
  final double? borderRadius;
  final BorderStyle? borderStyle;
  const OutlinedContainer({
    Key? key,
    required this.child,
    this.borderColor,
    this.backgroundColor,
    this.clipBehavior = Clip.none,
    this.borderRadius,
    this.borderStyle,
  }) : super(key: key);

  @override
  State<OutlinedContainer> createState() => _OutlinedContainerState();
}

class _OutlinedContainerState extends State<OutlinedContainer> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AnimatedContainer(
      duration: kDefaultDuration,
      clipBehavior: widget.clipBehavior,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? theme.colorScheme.background,
        border: Border.all(
          color: widget.borderColor ?? theme.colorScheme.muted,
          width: 1,
          style: widget.borderStyle ?? BorderStyle.solid,
        ),
        borderRadius:
            BorderRadius.circular(widget.borderRadius ?? theme.radiusXl),
      ),
      child: widget.child,
    );
  }
}

class Dashed extends StatelessWidget {
  final double width;
  final double gap;
  final double thickness;
  final Color? color;
  final Widget child;
  final BorderRadius? borderRadius;

  const Dashed({
    super.key,
    this.width = 8,
    this.gap = 5,
    this.thickness = 1,
    this.color,
    required this.child,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomPaint(
      painter: DashedPainter(
        width: width,
        gap: gap,
        thickness: thickness,
        color: color ?? theme.colorScheme.border,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

class DashedLine extends StatelessWidget {
  final double width;
  final double gap;
  final double thickness;
  final Color? color;

  const DashedLine({
    super.key,
    this.width = 8,
    this.gap = 5,
    this.thickness = 1,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomPaint(
      painter: DashedLinePainter(
        width: width,
        gap: gap,
        thickness: thickness,
        color: color ?? theme.colorScheme.border,
      ),
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
        draw.addPath(
          pathMetric.extractPath(start, end),
          Offset.zero,
        );
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
    if (borderRadius != null) {
      path.addRRect(RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, size.width, size.height),
        topLeft: borderRadius!.topLeft,
        topRight: borderRadius!.topRight,
        bottomLeft: borderRadius!.bottomLeft,
        bottomRight: borderRadius!.bottomRight,
      ));
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
        draw.addPath(
          pathMetric.extractPath(start, end),
          Offset.zero,
        );
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
