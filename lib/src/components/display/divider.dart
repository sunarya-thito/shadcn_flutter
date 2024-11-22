import 'dart:ui';

import '../../../shadcn_flutter.dart';

class DividerProperties {
  final Color color;
  final double thickness;
  final double indent;
  final double endIndent;

  const DividerProperties({
    required this.color,
    required this.thickness,
    required this.indent,
    required this.endIndent,
  });

  static DividerProperties lerp(
      DividerProperties a, DividerProperties b, double t) {
    return DividerProperties(
      color: Color.lerp(a.color, b.color, t)!,
      thickness: lerpDouble(a.thickness, b.thickness, t)!,
      indent: lerpDouble(a.indent, b.indent, t)!,
      endIndent: lerpDouble(a.endIndent, b.endIndent, t)!,
    );
  }
}

class Divider extends StatelessWidget implements PreferredSizeWidget {
  final Color? color;
  final double? height;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  const Divider({
    super.key,
    this.color,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.child,
    this.padding,
  });

  @override
  Size get preferredSize => Size(0, height ?? 1);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (child != null) {
      return SizedBox(
        width: double.infinity,
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SizedBox(
                  height: height ?? 1,
                  child: AnimatedValueBuilder(
                      value: DividerProperties(
                        color: color ?? theme.colorScheme.border,
                        thickness: thickness ?? 1,
                        indent: indent ?? 0,
                        endIndent: 0,
                      ),
                      duration: kDefaultDuration,
                      lerp: DividerProperties.lerp,
                      builder: (context, value, child) {
                        return CustomPaint(
                          painter: DividerPainter(
                            color: value.color,
                            thickness: value.thickness,
                            indent: value.indent,
                            endIndent: value.endIndent,
                          ),
                        );
                      }),
                ),
              ),
              child!.muted().small().withPadding(
                  padding: padding ??
                      EdgeInsets.symmetric(horizontal: theme.scaling * 8)),
              Expanded(
                child: SizedBox(
                  height: height ?? 1,
                  child: AnimatedValueBuilder(
                      value: DividerProperties(
                        color: color ?? theme.colorScheme.border,
                        thickness: thickness ?? 1,
                        indent: 0,
                        endIndent: endIndent ?? 0,
                      ),
                      duration: kDefaultDuration,
                      lerp: DividerProperties.lerp,
                      builder: (context, value, child) {
                        return CustomPaint(
                          painter: DividerPainter(
                            color: value.color,
                            thickness: value.thickness,
                            indent: value.indent,
                            endIndent: value.endIndent,
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return SizedBox(
      height: height ?? 1,
      width: double.infinity,
      child: AnimatedValueBuilder(
          value: DividerProperties(
            color: color ?? theme.colorScheme.border,
            thickness: thickness ?? 1,
            indent: indent ?? 0,
            endIndent: endIndent ?? 0,
          ),
          lerp: DividerProperties.lerp,
          duration: kDefaultDuration,
          builder: (context, value, child) {
            return CustomPaint(
              painter: DividerPainter(
                color: value.color,
                thickness: value.thickness,
                indent: value.indent,
                endIndent: value.endIndent,
              ),
            );
          }),
    );
  }
}

class DividerPainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double indent;
  final double endIndent;

  DividerPainter({
    required this.color,
    required this.thickness,
    required this.indent,
    required this.endIndent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.square;
    final start = Offset(indent, size.height / 2);
    final end = Offset(size.width - endIndent, size.height / 2);
    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant DividerPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.thickness != thickness ||
        oldDelegate.indent != indent ||
        oldDelegate.endIndent != endIndent;
  }
}

class VerticalDividerPainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double indent;
  final double endIndent;

  const VerticalDividerPainter({
    required this.color,
    required this.thickness,
    required this.indent,
    required this.endIndent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.square;
    final start = Offset(size.width / 2, indent);
    final end = Offset(size.width / 2, size.height - endIndent);
    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant VerticalDividerPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.thickness != thickness ||
        oldDelegate.indent != indent ||
        oldDelegate.endIndent != endIndent;
  }
}

class VerticalDivider extends StatelessWidget implements PreferredSizeWidget {
  final Color? color;
  final double? width;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  const VerticalDivider({
    super.key,
    this.color,
    this.width,
    this.thickness,
    this.indent,
    this.endIndent,
    this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
  });

  @override
  Size get preferredSize => Size(width ?? 1, 0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (child != null) {
      return SizedBox(
        height: double.infinity,
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SizedBox(
                  width: width ?? 1,
                  child: AnimatedValueBuilder(
                      value: DividerProperties(
                        color: color ?? theme.colorScheme.border,
                        thickness: thickness ?? 1,
                        indent: indent ?? 0,
                        endIndent: 0,
                      ),
                      duration: kDefaultDuration,
                      lerp: DividerProperties.lerp,
                      builder: (context, value, child) {
                        return CustomPaint(
                          painter: VerticalDividerPainter(
                            color: value.color,
                            thickness: value.thickness,
                            indent: value.indent,
                            endIndent: value.endIndent,
                          ),
                        );
                      }),
                ),
              ),
              child!.muted().small().withPadding(padding: padding),
              Expanded(
                child: SizedBox(
                  width: width ?? 1,
                  child: AnimatedValueBuilder(
                      value: DividerProperties(
                        color: color ?? theme.colorScheme.border,
                        thickness: thickness ?? 1,
                        indent: 0,
                        endIndent: endIndent ?? 0,
                      ),
                      duration: kDefaultDuration,
                      lerp: DividerProperties.lerp,
                      builder: (context, value, child) {
                        return CustomPaint(
                          painter: VerticalDividerPainter(
                            color: value.color,
                            thickness: value.thickness,
                            indent: value.indent,
                            endIndent: value.endIndent,
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return SizedBox(
      width: width ?? 1,
      height: double.infinity,
      child: AnimatedValueBuilder(
          value: DividerProperties(
            color: color ?? theme.colorScheme.border,
            thickness: thickness ?? 1,
            indent: indent ?? 0,
            endIndent: endIndent ?? 0,
          ),
          lerp: DividerProperties.lerp,
          duration: kDefaultDuration,
          builder: (context, value, child) {
            return CustomPaint(
              painter: VerticalDividerPainter(
                color: value.color,
                thickness: value.thickness,
                indent: value.indent,
                endIndent: value.endIndent,
              ),
            );
          }),
    );
  }
}
