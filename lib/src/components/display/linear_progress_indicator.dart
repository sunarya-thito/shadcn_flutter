import 'dart:ui' as ui;

import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme configuration for [LinearProgressIndicator] components.
///
/// Provides comprehensive visual styling properties for linear progress indicators
/// including colors, sizing, border radius, and visual effects. These properties
/// integrate with the design system and can be overridden at the widget level.
///
/// The theme supports advanced features like spark effects for enhanced visual
/// feedback and animation control for performance optimization scenarios.
class LinearProgressIndicatorTheme {
  /// The primary color of the progress indicator fill.
  ///
  /// Type: `Color?`. If null, uses theme's primary color. Applied to the
  /// filled portion that represents completion progress.
  final Color? color;

  /// The background color behind the progress indicator.
  ///
  /// Type: `Color?`. If null, uses a semi-transparent version of the primary color.
  /// Visible in the unfilled portion of the progress track.
  final Color? backgroundColor;

  /// The minimum height of the progress indicator.
  ///
  /// Type: `double?`. If null, defaults to 2.0 scaled by theme scaling factor.
  /// Ensures adequate visual presence while maintaining sleek appearance.
  final double? minHeight;

  /// The border radius of the progress indicator container.
  ///
  /// Type: `BorderRadiusGeometry?`. If null, uses BorderRadius.zero for sharp edges.
  /// Applied to both the track and progress fill for consistent styling.
  final BorderRadiusGeometry? borderRadius;

  /// Whether to display spark effects at the progress head.
  ///
  /// Type: `bool?`. If null, defaults to false. When enabled, shows a
  /// radial gradient spark effect at the leading edge of the progress fill.
  final bool? showSparks;

  /// Whether to disable smooth progress animations.
  ///
  /// Type: `bool?`. If null, defaults to false. When true, progress changes
  /// instantly without transitions for performance optimization.
  final bool? disableAnimation;

  /// Creates a [LinearProgressIndicatorTheme].
  ///
  /// All parameters are optional and can be null to use intelligent defaults
  /// based on the current theme configuration and design system values.
  ///
  /// Example:
  /// ```dart
  /// const LinearProgressIndicatorTheme(
  ///   color: Colors.blue,
  ///   backgroundColor: Colors.grey,
  ///   minHeight: 4.0,
  ///   borderRadius: BorderRadius.circular(2.0),
  ///   showSparks: true,
  /// );
  /// ```
  const LinearProgressIndicatorTheme({
    this.color,
    this.backgroundColor,
    this.minHeight,
    this.borderRadius,
    this.showSparks,
    this.disableAnimation,
  });

  /// Returns a copy of this theme with the given fields replaced.
  LinearProgressIndicatorTheme copyWith({
    ValueGetter<Color?>? color,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<double?>? minHeight,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<bool?>? showSparks,
    ValueGetter<bool?>? disableAnimation,
  }) {
    return LinearProgressIndicatorTheme(
      color: color == null ? this.color : color(),
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      minHeight: minHeight == null ? this.minHeight : minHeight(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      showSparks: showSparks == null ? this.showSparks : showSparks(),
      disableAnimation:
          disableAnimation == null ? this.disableAnimation : disableAnimation(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LinearProgressIndicatorTheme &&
        other.color == color &&
        other.backgroundColor == backgroundColor &&
        other.minHeight == minHeight &&
        other.borderRadius == borderRadius &&
        other.showSparks == showSparks &&
        other.disableAnimation == disableAnimation;
  }

  @override
  int get hashCode => Object.hash(
        color,
        backgroundColor,
        minHeight,
        borderRadius,
        showSparks,
        disableAnimation,
      );
}

/// Duration constant for indeterminate linear progress animation cycle.
///
/// Defines the complete animation cycle duration (1800ms) for the dual-line
/// indeterminate progress pattern, ensuring smooth and consistent motion timing.
const int _kIndeterminateLinearDuration = 1800;

/// A sophisticated linear progress indicator with advanced visual effects.
///
/// The LinearProgressIndicator provides both determinate and indeterminate progress
/// visualization with enhanced features including optional spark effects, smooth
/// animations, and comprehensive theming support. Built with custom painting for
/// precise control over visual presentation and performance.
///
/// For determinate progress, displays completion as a horizontal bar that fills
/// from left to right. For indeterminate progress (when value is null), shows
/// a continuous animation with two overlapping progress segments that move across
/// the track in a coordinated pattern.
///
/// Key features:
/// - Determinate and indeterminate progress modes
/// - Optional spark effects with radial gradient animation
/// - Smooth animated transitions with disable option
/// - RTL (right-to-left) text direction support
/// - Custom painting for optimal rendering performance
/// - Comprehensive theming via [LinearProgressIndicatorTheme]
/// - Responsive sizing with theme scaling integration
///
/// The indeterminate animation uses precisely timed curves to create a natural,
/// material design compliant motion pattern that communicates ongoing activity
/// without specific completion timing.
///
/// Example:
/// ```dart
/// LinearProgressIndicator(
///   value: 0.7,
///   showSparks: true,
///   color: Colors.blue,
///   minHeight: 6.0,
/// );
/// ```
class LinearProgressIndicator extends StatelessWidget {
  /// Animation curve constants for indeterminate progress motion.
  ///
  /// These curves define the precise timing and easing for the dual-line
  /// indeterminate animation pattern, creating smooth material design motion.
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

  /// The progress completion value between 0.0 and 1.0.
  ///
  /// Type: `double?`. If null, displays indeterminate animation with dual
  /// moving progress segments. When provided, shows determinate progress.
  final double? value;

  /// The background color of the progress track.
  ///
  /// Type: `Color?`. If null, uses theme background color or semi-transparent
  /// version of progress color. Overrides theme configuration.
  final Color? backgroundColor;

  /// The minimum height of the progress indicator.
  ///
  /// Type: `double?`. If null, uses theme minimum height or 2.0 scaled
  /// by theme scaling factor. Overrides theme configuration.
  final double? minHeight;

  /// The primary color of the progress fill.
  ///
  /// Type: `Color?`. If null, uses theme primary color. Applied to both
  /// progress segments in indeterminate mode. Overrides theme configuration.
  final Color? color;

  /// The border radius of the progress container.
  ///
  /// Type: `BorderRadiusGeometry?`. If null, uses BorderRadius.zero.
  /// Applied via [ClipRRect] to both track and progress elements.
  final BorderRadiusGeometry? borderRadius;

  /// Whether to display spark effects at the progress head.
  ///
  /// Type: `bool?`. If null, defaults to false. Shows radial gradient
  /// spark effect at the leading edge for enhanced visual feedback.
  final bool? showSparks;

  /// Whether to disable smooth progress animations.
  ///
  /// Type: `bool?`. If null, defaults to false. When true, disables
  /// [AnimatedValueBuilder] for instant progress changes.
  final bool? disableAnimation;

  /// Creates a [LinearProgressIndicator].
  ///
  /// The component automatically handles both determinate and indeterminate modes
  /// based on whether [value] is provided. Theming and visual effects can be
  /// customized through individual parameters or via [LinearProgressIndicatorTheme].
  ///
  /// Parameters:
  /// - [value] (double?, optional): Progress completion (0.0-1.0) or null for indeterminate
  /// - [backgroundColor] (Color?, optional): Track background color override
  /// - [minHeight] (double?, optional): Minimum indicator height override
  /// - [color] (Color?, optional): Progress fill color override
  /// - [borderRadius] (BorderRadiusGeometry?, optional): Container border radius override
  /// - [showSparks] (bool?, optional): Whether to show spark effects
  /// - [disableAnimation] (bool?, optional): Whether to disable smooth transitions
  ///
  /// Example:
  /// ```dart
  /// LinearProgressIndicator(
  ///   value: 0.4,
  ///   color: Colors.green,
  ///   backgroundColor: Colors.grey.shade300,
  ///   minHeight: 8.0,
  ///   showSparks: true,
  /// );
  /// ```
  const LinearProgressIndicator({
    super.key,
    this.value,
    this.backgroundColor,
    this.minHeight,
    this.color,
    this.borderRadius,
    this.showSparks,
    this.disableAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final directionality = Directionality.of(context);
    final compTheme = ComponentTheme.maybeOf<LinearProgressIndicatorTheme>(
      context,
    );
    final colorValue = styleValue(
      widgetValue: color,
      themeValue: compTheme?.color,
      defaultValue: theme.colorScheme.primary,
    );
    final backgroundColorValue = styleValue(
      widgetValue: backgroundColor,
      themeValue: compTheme?.backgroundColor,
      defaultValue: colorValue.scaleAlpha(0.2),
    );
    final minHeightValue = styleValue(
      widgetValue: minHeight,
      themeValue: compTheme?.minHeight,
      defaultValue: theme.scaling * 2,
    );
    final borderRadiusValue = styleValue(
      widgetValue: borderRadius,
      themeValue: compTheme?.borderRadius,
      defaultValue: BorderRadius.zero,
    );
    final showSparksValue = styleValue(
      widgetValue: showSparks,
      themeValue: compTheme?.showSparks,
      defaultValue: false,
    );
    final disableAnimationValue = styleValue(
      widgetValue: disableAnimation,
      themeValue: compTheme?.disableAnimation,
      defaultValue: false,
    );
    Widget childWidget;
    if (value != null) {
      childWidget = AnimatedValueBuilder(
        value: _LinearProgressIndicatorProperties(
          start: 0,
          end: value!.clamp(0, 1),
          color: colorValue,
          backgroundColor: backgroundColorValue,
          showSparks: showSparksValue,
          sparksColor: colorValue,
          sparksRadius: theme.scaling * 16,
          textDirection: directionality,
        ),
        duration: disableAnimationValue ? Duration.zero : kDefaultDuration,
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
        },
      );
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
              color: colorValue,
              backgroundColor: backgroundColorValue,
              showSparks: showSparksValue,
              sparksColor: colorValue,
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
            },
          );
        },
      );
    }
    return RepaintBoundary(
      child: SizedBox(
        height: minHeightValue,
        child: ClipRRect(borderRadius: borderRadiusValue, child: childWidget),
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
      (Matrix4.identity()..scaleByDouble(1.0, 0.5, 1, 1)).storage;

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
        0,
        0,
        size.width,
        size.height,
        Radius.circular(size.height / 2),
      ),
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
        [sparksColor, sparksColor.withAlpha(0)],
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
