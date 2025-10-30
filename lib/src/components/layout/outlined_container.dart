import 'dart:ui';

import '../../../shadcn_flutter.dart';

/// A widget that applies a blur effect to its background.
///
/// Creates a frosted glass or translucent blur effect behind the child widget
/// using a backdrop filter. The blur amount is controlled by [surfaceBlur].
///
/// Example:
/// ```dart
/// SurfaceBlur(
///   surfaceBlur: 10,
///   borderRadius: BorderRadius.circular(8),
///   child: Container(
///     color: Colors.white.withOpacity(0.5),
///     child: Text('Blurred background'),
///   ),
/// )
/// ```
class SurfaceBlur extends StatefulWidget {
  /// The child widget to display with blurred background.
  final Widget child;

  /// The amount of blur to apply (sigma value for blur filter).
  ///
  /// If `null` or `<= 0`, no blur is applied.
  final double? surfaceBlur;

  /// Border radius for clipping the blur effect.
  ///
  /// If `null`, no rounding is applied.
  final BorderRadiusGeometry? borderRadius;

  /// Creates a [SurfaceBlur].
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

/// Theme configuration for [OutlinedContainer] appearance.
///
/// Defines styling properties including background color, border styles,
/// shadows, padding, and surface effects for outlined containers.
class OutlinedContainerTheme {
  /// Background color for the container.
  final Color? backgroundColor;

  /// Color of the container's border.
  final Color? borderColor;

  /// Border radius for rounded corners.
  final BorderRadiusGeometry? borderRadius;

  /// Style of the border (solid, dotted, etc).
  final BorderStyle? borderStyle;

  /// Width of the border in logical pixels.
  final double? borderWidth;

  /// Box shadows to apply for depth/elevation effects.
  final List<BoxShadow>? boxShadow;

  /// Padding inside the container.
  final EdgeInsetsGeometry? padding;

  /// Opacity for surface overlay effects.
  final double? surfaceOpacity;

  /// Blur amount for surface backdrop effects.
  final double? surfaceBlur;

  /// Creates an [OutlinedContainerTheme].
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

  /// Creates a copy of this theme with the given fields replaced.
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
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      borderColor: borderColor == null ? this.borderColor : borderColor(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      borderStyle: borderStyle == null ? this.borderStyle : borderStyle(),
      borderWidth: borderWidth == null ? this.borderWidth : borderWidth(),
      boxShadow: boxShadow == null ? this.boxShadow : boxShadow(),
      padding: padding == null ? this.padding : padding(),
      surfaceOpacity:
          surfaceOpacity == null ? this.surfaceOpacity : surfaceOpacity(),
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

/// A container widget with customizable border and surface effects.
///
/// Provides a styled container with border, background, shadows, padding,
/// and optional surface blur effects. Supports theming and animations.
///
/// Example:
/// ```dart
/// OutlinedContainer(
///   borderRadius: BorderRadius.circular(12),
///   borderColor: Colors.blue,
///   backgroundColor: Colors.white,
///   padding: EdgeInsets.all(16),
///   child: Text('Outlined content'),
/// )
/// ```
class OutlinedContainer extends StatefulWidget {
  /// The child widget to display inside the container.
  final Widget child;

  /// Background color of the container.
  ///
  /// If `null`, uses theme default.
  final Color? backgroundColor;

  /// Color of the container's border.
  ///
  /// If `null`, uses theme default.
  final Color? borderColor;

  /// How to clip the container's content.
  ///
  /// Defaults to [Clip.antiAlias].
  final Clip clipBehavior;

  /// Border radius for rounded corners.
  ///
  /// If `null`, uses theme default.
  final BorderRadiusGeometry? borderRadius;

  /// Style of the border.
  ///
  /// If `null`, uses [BorderStyle.solid].
  final BorderStyle? borderStyle;

  /// Width of the border in logical pixels.
  ///
  /// If `null`, uses theme default.
  final double? borderWidth;

  /// Box shadows for elevation effects.
  ///
  /// If `null`, no shadows are applied.
  final List<BoxShadow>? boxShadow;

  /// Padding inside the container.
  ///
  /// If `null`, uses theme default.
  final EdgeInsetsGeometry? padding;

  /// Opacity for surface overlay effects.
  ///
  /// If provided, modulates the background color's alpha.
  final double? surfaceOpacity;

  /// Blur amount for surface backdrop effects.
  ///
  /// If `null` or `<= 0`, no blur is applied.
  final double? surfaceBlur;

  /// Explicit width of the container.
  ///
  /// If `null`, size is determined by child and padding.
  final double? width;

  /// Explicit height of the container.
  ///
  /// If `null`, size is determined by child and padding.
  final double? height;

  /// Duration for animating property changes.
  ///
  /// If `null`, changes are applied immediately without animation.
  final Duration? duration;

  /// Creates an [OutlinedContainer].
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
      defaultValue: null,
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
      defaultValue: [],
    );
    final padding = styleValue<EdgeInsetsGeometry>(
      themeValue: compTheme?.padding,
      widgetValue: widget.padding,
      defaultValue: EdgeInsets.zero,
    );
    final surfaceBlur = styleValue<double?>(
      themeValue: compTheme?.surfaceBlur,
      widgetValue: widget.surfaceBlur,
      defaultValue: null,
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

/// Properties for defining a dashed line appearance.
///
/// Encapsulates the visual properties of a dashed line including dash width,
/// gap between dashes, thickness, and color. Supports interpolation for animations.
class DashedLineProperties {
  /// Width of each dash segment.
  final double width;

  /// Gap between consecutive dash segments.
  final double gap;

  /// Thickness (height) of the line.
  final double thickness;

  /// Color of the dashed line.
  final Color color;

  /// Creates [DashedLineProperties].
  const DashedLineProperties({
    required this.width,
    required this.gap,
    required this.thickness,
    required this.color,
  });

  /// Linearly interpolates between two [DashedLineProperties].
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

/// A widget that displays a horizontal dashed line.
///
/// Renders a customizable dashed line with configurable dash width, gap,
/// thickness, and color. Animates changes to properties smoothly.
///
/// Example:
/// ```dart
/// DashedLine(
///   width: 10,
///   gap: 5,
///   thickness: 2,
///   color: Colors.grey,
/// )
/// ```
class DashedLine extends StatelessWidget {
  /// Width of each dash segment.
  ///
  /// If `null`, uses scaled default (8).
  final double? width;

  /// Gap between consecutive dash segments.
  ///
  /// If `null`, uses scaled default (5).
  final double? gap;

  /// Thickness (height) of the line.
  ///
  /// If `null`, uses scaled default (1).
  final double? thickness;

  /// Color of the dashed line.
  ///
  /// If `null`, uses theme border color.
  final Color? color;

  /// Creates a [DashedLine].
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

/// Properties for defining a dashed container border appearance.
///
/// Encapsulates the visual properties of a dashed container border including
/// dash width, gap, thickness, color, and border radius. Supports interpolation.
class DashedContainerProperties {
  /// Width of each dash segment.
  final double width;

  /// Gap between consecutive dash segments.
  final double gap;

  /// Thickness of the border.
  final double thickness;

  /// Color of the dashed border.
  final Color color;

  /// Border radius for rounded corners.
  final BorderRadiusGeometry borderRadius;

  /// Creates [DashedContainerProperties].
  const DashedContainerProperties({
    required this.width,
    required this.gap,
    required this.thickness,
    required this.color,
    required this.borderRadius,
  });

  /// Linearly interpolates between two [DashedContainerProperties].
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

/// A container with a dashed border outline.
///
/// Renders a container with a customizable dashed border that can have rounded
/// corners. Animates border property changes smoothly.
///
/// Example:
/// ```dart
/// DashedContainer(
///   strokeWidth: 10,
///   gap: 5,
///   thickness: 2,
///   borderRadius: BorderRadius.circular(8),
///   child: Padding(
///     padding: EdgeInsets.all(16),
///     child: Text('Dashed border'),
///   ),
/// )
/// ```
class DashedContainer extends StatelessWidget {
  /// Width of each dash segment.
  ///
  /// If `null`, uses scaled default (8).
  final double? strokeWidth;

  /// Gap between consecutive dash segments.
  ///
  /// If `null`, uses scaled default (5).
  final double? gap;

  /// Thickness of the border.
  ///
  /// If `null`, uses scaled default (1).
  final double? thickness;

  /// Color of the dashed border.
  ///
  /// If `null`, uses theme border color.
  final Color? color;

  /// The child widget inside the container.
  final Widget child;

  /// Border radius for rounded corners.
  ///
  /// If `null`, uses theme default border radius.
  final BorderRadiusGeometry? borderRadius;

  /// Creates a [DashedContainer].
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

/// A custom painter that draws a dashed horizontal line.
///
/// Paints a line with alternating dashes and gaps.
class DashedLinePainter extends CustomPainter {
  /// Width of each dash segment.
  final double width;

  /// Gap between dash segments.
  final double gap;

  /// Thickness of the line.
  final double thickness;

  /// Color of the dashed line.
  final Color color;

  /// Creates a [DashedLinePainter].
  ///
  /// Parameters:
  /// - [width] (`double`, required): Dash segment width.
  /// - [gap] (`double`, required): Gap between dashes.
  /// - [thickness] (`double`, required): Line thickness.
  /// - [color] (`Color`, required): Line color.
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

/// A custom painter that draws a dashed border around a rectangle.
///
/// Paints a dashed border with optional rounded corners.
class DashedPainter extends CustomPainter {
  /// Width of each dash segment.
  final double width;

  /// Gap between dash segments.
  final double gap;

  /// Thickness of the border.
  final double thickness;

  /// Color of the dashed border.
  final Color color;

  /// Border radius for rounded corners.
  final BorderRadius? borderRadius;

  /// Creates a [DashedPainter].
  ///
  /// Parameters:
  /// - [width] (`double`, required): Dash segment width.
  /// - [gap] (`double`, required): Gap between dashes.
  /// - [thickness] (`double`, required): Border thickness.
  /// - [color] (`Color`, required): Border color.
  /// - [borderRadius] (`BorderRadius?`, optional): Corner radius.
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
