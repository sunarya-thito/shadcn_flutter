import 'dart:math' as math;

import '../../../shadcn_flutter.dart';

/// Theme configuration for [CircularProgressIndicator] components.
///
/// Provides visual styling properties for circular progress indicators including
/// colors, sizing, and stroke characteristics. These properties integrate with
/// the design system and can be overridden at the widget level.
///
/// All theme values respect the current theme's scaling factor and color scheme
/// for consistent visual presentation across different screen densities and themes.
class CircularProgressIndicatorTheme extends ComponentThemeData {
  /// The primary color of the progress indicator arc.
  ///
  /// Type: `Color?`. If null, uses theme's primary color or background color
  /// when [onSurface] is true. Applied to the filled portion of the circular track.
  final Color? color;

  /// The background color of the progress indicator track.
  ///
  /// Type: `Color?`. If null, uses a semi-transparent version of the primary color.
  /// Visible in the unfilled portion of the circular track.
  final Color? backgroundColor;

  /// The diameter size of the circular progress indicator.
  ///
  /// Type: `double?`. If null, derives size from current icon theme size minus padding.
  /// Determines the overall dimensions of the circular progress display.
  final double? size;

  /// The width of the progress indicator stroke.
  ///
  /// Type: `double?`. If null, calculates as size/12 for proportional appearance.
  /// Controls the thickness of both the progress arc and background track.
  final double? strokeWidth;

  /// Creates a [CircularProgressIndicatorTheme].
  ///
  /// All parameters are optional and can be null to use intelligent defaults
  /// based on the current theme configuration and icon context.
  ///
  /// Example:
  /// ```dart
  /// const CircularProgressIndicatorTheme(
  ///   color: Colors.blue,
  ///   backgroundColor: Colors.grey,
  ///   size: 32.0,
  ///   strokeWidth: 3.0,
  /// );
  /// ```
  const CircularProgressIndicatorTheme({
    this.color,
    this.backgroundColor,
    this.size,
    this.strokeWidth,
  });

  /// Creates a copy of this theme with the given fields replaced.
  CircularProgressIndicatorTheme copyWith({
    ValueGetter<Color?>? color,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<double?>? size,
    ValueGetter<double?>? strokeWidth,
  }) {
    return CircularProgressIndicatorTheme(
      color: color == null ? this.color : color(),
      backgroundColor: backgroundColor == null
          ? this.backgroundColor
          : backgroundColor(),
      size: size == null ? this.size : size(),
      strokeWidth: strokeWidth == null ? this.strokeWidth : strokeWidth(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CircularProgressIndicatorTheme &&
        other.color == color &&
        other.backgroundColor == backgroundColor &&
        other.size == size &&
        other.strokeWidth == strokeWidth;
  }

  @override
  int get hashCode => Object.hash(color, backgroundColor, size, strokeWidth);
}

/// A circular progress indicator that displays task completion as a rotating arc.
///
/// The CircularProgressIndicator provides both determinate and indeterminate
/// progress visualization in a compact circular format. When a specific progress
/// value is provided, it shows completion as a filled arc. When value is null,
/// it displays a continuous spinning animation.
///
/// Painted directly by this package rather than delegating to Material, so it
/// carries no dependency on the Material library. Automatically adapts sizing
/// based on the current [IconTheme] context while providing manual size
/// override options.
///
/// Key features:
/// - Determinate and indeterminate progress modes
/// - Automatic sizing based on icon context with manual overrides
/// - Smooth value animations with configurable duration
/// - Surface mode for display on colored backgrounds
/// - Comprehensive theming via [CircularProgressIndicatorTheme]
/// - Performance-optimized rendering with [RepaintBoundary]
///
/// The component intelligently calculates default colors and sizing based on
/// the current theme and icon context, ensuring consistent visual integration.
///
/// Example:
/// ```dart
/// CircularProgressIndicator(
///   value: 0.75,
///   size: 32.0,
///   color: Colors.blue,
/// );
/// ```
class CircularProgressIndicator extends StatelessWidget {
  /// The progress completion value between 0.0 and 1.0.
  ///
  /// Type: `double?`. If null, displays indeterminate spinning animation.
  /// When provided, shows progress as a filled arc from 0% to value*100%.
  final double? value;

  /// The explicit diameter size of the progress indicator.
  ///
  /// Type: `double?`. If null, derives size from current icon theme size
  /// minus theme scaling padding. Overrides theme and automatic sizing.
  final double? size;

  /// The primary color of the progress arc.
  ///
  /// Type: `Color?`. If null, uses theme color or background color when
  /// [onSurface] is true. Overrides theme configuration.
  final Color? color;

  /// The background color of the progress track.
  ///
  /// Type: `Color?`. If null, uses a semi-transparent version of the
  /// primary color. Overrides theme configuration.
  final Color? backgroundColor;

  /// The width of the progress stroke line.
  ///
  /// Type: `double?`. If null, calculates proportionally as size/12.
  /// Controls the thickness of both progress and background arcs.
  final double? strokeWidth;

  /// The duration for smooth progress value transitions.
  ///
  /// Type: `Duration`, default: [kDefaultDuration]. Only applied when
  /// [animated] is true and [value] is provided for determinate progress.
  final Duration duration;

  /// Whether to animate progress value changes.
  ///
  /// Type: `bool`, default: `true`. When false, progress changes instantly.
  /// When true with determinate value, uses [AnimatedValueBuilder] for smooth transitions.
  final bool animated;

  /// Whether the indicator is displayed on a colored surface.
  ///
  /// Type: `bool`, default: `false`. When true, uses background color instead
  /// of primary color for better visibility on colored backgrounds.
  final bool onSurface;

  /// Creates a [CircularProgressIndicator].
  ///
  /// The component automatically handles both determinate and indeterminate modes
  /// based on whether [value] is provided. Size and colors adapt intelligently
  /// based on theme context unless explicitly overridden.
  ///
  /// Parameters:
  /// - [value] (double?, optional): Progress completion (0.0-1.0) or null for indeterminate
  /// - [size] (double?, optional): Explicit diameter size override
  /// - [color] (Color?, optional): Primary progress arc color override
  /// - [backgroundColor] (Color?, optional): Background track color override
  /// - [strokeWidth] (double?, optional): Progress stroke thickness override
  /// - [duration] (Duration, default: kDefaultDuration): Animation duration for value changes
  /// - [animated] (bool, default: true): Whether to animate progress transitions
  /// - [onSurface] (bool, default: false): Whether displayed on colored background
  ///
  /// Example:
  /// ```dart
  /// CircularProgressIndicator(
  ///   value: 0.6,
  ///   size: 24.0,
  ///   strokeWidth: 2.0,
  ///   animated: true,
  /// );
  /// ```
  const CircularProgressIndicator({
    super.key,
    this.value,
    this.size,
    this.color,
    this.backgroundColor,
    this.strokeWidth,
    this.duration = kDefaultDuration,
    this.animated = true,
    this.onSurface = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconThemeData = IconTheme.of(context);
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<CircularProgressIndicatorTheme>(
      context,
    );

    final effectiveSize = styleValue(
      widgetValue: size,
      themeValue: compTheme?.size,
      defaultValue:
          (iconThemeData.size ?? 24 * theme.scaling) - 8 * theme.scaling,
    );

    final effectiveColor = styleValue(
      widgetValue: color,
      themeValue: compTheme?.color,
      defaultValue: onSurface
          ? theme.colorScheme.background
          : theme.colorScheme.primary,
    );

    final effectiveBackgroundColor = styleValue(
      widgetValue: backgroundColor,
      themeValue: compTheme?.backgroundColor,
      defaultValue: effectiveColor.scaleAlpha(0.2),
    );

    final effectiveStrokeWidth = styleValue(
      widgetValue: strokeWidth,
      themeValue: compTheme?.strokeWidth,
      defaultValue: effectiveSize / 12,
    );

    if (value == null || !animated) {
      return RepaintBoundary(
        child: SizedBox(
          width: effectiveSize,
          height: effectiveSize,
          child: _CircularSpinner(
            color: effectiveColor,
            backgroundColor: effectiveBackgroundColor,
            strokeWidth: effectiveStrokeWidth,
            value: value,
          ),
        ),
      );
    } else {
      return AnimatedValueBuilder(
        value: value!,
        duration: duration,
        builder: (context, value, child) {
          return RepaintBoundary(
            child: SizedBox(
              width: effectiveSize,
              height: effectiveSize,
              child: _CircularSpinner(
                color: effectiveColor,
                backgroundColor: effectiveBackgroundColor,
                strokeWidth: effectiveStrokeWidth,
                value: value,
              ),
            ),
          );
        },
      );
    }
  }
}

/// Total duration of one full indeterminate cycle.
///
/// Chosen so that the arc-growth cycle (1333ms) and the rotation cycle (2222ms)
/// both divide it evenly, which lets a single controller drive both without the
/// two ever drifting out of phase. Ported from Flutter's Material implementation
/// (BSD-licensed, see the Flutter LICENSE file).
const int _kIndeterminateCircularDuration = 1333 * 2222;

/// The circular arc renderer behind [CircularProgressIndicator].
///
/// Draws a background track plus a foreground arc. When [value] is null the arc
/// head and tail are animated independently to produce the familiar
/// grow/shrink/rotate spinner; when [value] is set the arc is a static sweep.
class _CircularSpinner extends StatefulWidget {
  /// Progress in the range 0.0-1.0, or null for the indeterminate spinner.
  final double? value;

  /// Color of the progress arc.
  final Color color;

  /// Color of the track behind the progress arc.
  final Color backgroundColor;

  /// Thickness of both the arc and the track.
  final double strokeWidth;

  const _CircularSpinner({
    required this.value,
    required this.color,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  State<_CircularSpinner> createState() => _CircularSpinnerState();
}

class _CircularSpinnerState extends State<_CircularSpinner>
    with SingleTickerProviderStateMixin {
  static const int _pathCount = _kIndeterminateCircularDuration ~/ 1333;
  static const int _rotationCount = _kIndeterminateCircularDuration ~/ 2222;

  static final Animatable<double> _strokeHeadTween = CurveTween(
    curve: const Interval(0.0, 0.5, curve: Curves.fastOutSlowIn),
  ).chain(CurveTween(curve: const SawTooth(_pathCount)));
  static final Animatable<double> _strokeTailTween = CurveTween(
    curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
  ).chain(CurveTween(curve: const SawTooth(_pathCount)));
  static final Animatable<double> _offsetTween = CurveTween(
    curve: const SawTooth(_pathCount),
  );
  static final Animatable<double> _rotationTween = CurveTween(
    curve: const SawTooth(_rotationCount),
  );

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: _kIndeterminateCircularDuration),
      vsync: this,
    );
    _updateAnimatingStatus();
  }

  @override
  void didUpdateWidget(covariant _CircularSpinner oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateAnimatingStatus();
  }

  /// Only spin while indeterminate, so a determinate indicator costs no ticks.
  void _updateAnimatingStatus() {
    if (widget.value == null) {
      if (!_controller.isAnimating) {
        _controller.repeat();
      }
    } else if (_controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _paint(
    double headValue,
    double tailValue,
    double offsetValue,
    double rotationValue,
  ) {
    return CustomPaint(
      painter: _CircularProgressPainter(
        trackColor: widget.backgroundColor,
        valueColor: widget.color,
        value: widget.value,
        headValue: headValue,
        tailValue: tailValue,
        offsetValue: offsetValue,
        rotationValue: rotationValue,
        strokeWidth: widget.strokeWidth,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value != null) {
      return _paint(0.0, 0.0, 0.0, 0.0);
    }
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return _paint(
          _strokeHeadTween.evaluate(_controller),
          _strokeTailTween.evaluate(_controller),
          _offsetTween.evaluate(_controller),
          _rotationTween.evaluate(_controller),
        );
      },
    );
  }
}

/// Paints the track and progress arc of a [CircularProgressIndicator].
///
/// Ported from Flutter's Material `_CircularProgressIndicatorPainter`
/// (BSD-licensed, see the Flutter LICENSE file) so that shadcn_flutter does not
/// depend on the Material library. Trimmed to the parameters this package
/// exposes: there is no stroke alignment, stroke cap or track gap override.
class _CircularProgressPainter extends CustomPainter {
  _CircularProgressPainter({
    required this.trackColor,
    required this.valueColor,
    required this.value,
    required this.headValue,
    required this.tailValue,
    required this.offsetValue,
    required this.rotationValue,
    required this.strokeWidth,
  }) : arcStart = value != null
           ? _startAngle
           : _startAngle +
                 tailValue * 3 / 2 * math.pi +
                 rotationValue * math.pi * 2.0 +
                 offsetValue * 0.5 * math.pi,
       arcSweep = value != null
           ? value.clamp(0.0, 1.0) * _sweep
           : math.max(
               headValue * 3 / 2 * math.pi - tailValue * 3 / 2 * math.pi,
               _epsilon,
             );

  final Color trackColor;
  final Color valueColor;
  final double? value;
  final double headValue;
  final double tailValue;
  final double offsetValue;
  final double rotationValue;
  final double strokeWidth;
  final double arcStart;
  final double arcSweep;

  static const double _twoPi = math.pi * 2.0;
  static const double _epsilon = .001;
  // Canvas.drawArc(r, 0, 2*PI) doesn't draw anything, so just get close.
  static const double _sweep = _twoPi - _epsilon;
  static const double _startAngle = -math.pi / 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect arcRect = Offset.zero & size;

    canvas.drawArc(
      arcRect,
      0,
      _sweep,
      false,
      Paint()
        ..color = trackColor
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke,
    );

    canvas.drawArc(
      arcRect,
      arcStart,
      arcSweep,
      false,
      Paint()
        ..color = valueColor
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(_CircularProgressPainter oldPainter) {
    return oldPainter.trackColor != trackColor ||
        oldPainter.valueColor != valueColor ||
        oldPainter.value != value ||
        oldPainter.headValue != headValue ||
        oldPainter.tailValue != tailValue ||
        oldPainter.offsetValue != offsetValue ||
        oldPainter.rotationValue != rotationValue ||
        oldPainter.strokeWidth != strokeWidth;
  }
}
