import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme configuration for [OverflowMarquee] scrolling text displays.
///
/// Provides comprehensive styling and behavior options for marquee animations
/// including scroll direction, timing, fade effects, and animation curves.
/// All properties are optional and will fall back to default values when not specified.
///
/// Animation Properties:
/// - [direction]: Horizontal or vertical scrolling axis
/// - [duration]: Complete cycle time for one full scroll
/// - [delayDuration]: Pause time before restarting animation
/// - [curve]: Easing function for smooth animation transitions
///
/// Visual Properties:
/// - [step]: Pixel step size for scroll speed calculation
/// - [fadePortion]: Edge fade effect intensity (0.0 to 1.0)
///
/// Example:
/// ```dart
/// OverflowMarqueeTheme(
///   direction: Axis.horizontal,
///   duration: Duration(seconds: 5),
///   delayDuration: Duration(seconds: 1),
///   fadePortion: 0.1,
///   curve: Curves.easeInOut,
/// )
/// ```
class OverflowMarqueeTheme {
  /// Scrolling direction of the marquee.
  final Axis? direction;

  /// Duration of one full scroll cycle.
  final Duration? duration;

  /// Delay before scrolling starts again.
  final Duration? delayDuration;

  /// Step size used to compute scroll speed.
  final double? step;

  /// Portion of the child to fade at the edges.
  final double? fadePortion;

  /// Animation curve of the scroll.
  final Curve? curve;

  /// Creates an [OverflowMarqueeTheme].
  const OverflowMarqueeTheme({
    this.direction,
    this.duration,
    this.delayDuration,
    this.step,
    this.fadePortion,
    this.curve,
  });

  /// Creates a copy of this theme with the given fields replaced.
  OverflowMarqueeTheme copyWith({
    ValueGetter<Axis?>? direction,
    ValueGetter<Duration?>? duration,
    ValueGetter<Duration?>? delayDuration,
    ValueGetter<double?>? step,
    ValueGetter<double?>? fadePortion,
    ValueGetter<Curve?>? curve,
  }) {
    return OverflowMarqueeTheme(
      direction: direction == null ? this.direction : direction(),
      duration: duration == null ? this.duration : duration(),
      delayDuration:
          delayDuration == null ? this.delayDuration : delayDuration(),
      step: step == null ? this.step : step(),
      fadePortion: fadePortion == null ? this.fadePortion : fadePortion(),
      curve: curve == null ? this.curve : curve(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OverflowMarqueeTheme &&
        other.direction == direction &&
        other.duration == duration &&
        other.delayDuration == delayDuration &&
        other.step == step &&
        other.fadePortion == fadePortion &&
        other.curve == curve;
  }

  @override
  int get hashCode =>
      Object.hash(direction, duration, delayDuration, step, fadePortion, curve);
}

/// Automatically scrolling widget for content that overflows its container.
///
/// Creates smooth, continuous scrolling animation for content that exceeds the
/// available space. Commonly used for long text labels, news tickers, or any
/// content that needs horizontal or vertical scrolling to be fully visible.
///
/// Key Features:
/// - **Auto-scroll Detection**: Only animates when content actually overflows
/// - **Bi-directional Support**: Horizontal and vertical scrolling modes
/// - **Edge Fading**: Smooth fade effects at container boundaries
/// - **Customizable Timing**: Configurable duration, delay, and animation curves
/// - **Performance Optimized**: Uses Flutter's Ticker system for smooth 60fps animation
/// - **Theme Integration**: Respects OverflowMarqueeTheme configuration
///
/// Animation Behavior:
/// 1. Measures content size vs. container size
/// 2. If content fits, displays normally without animation
/// 3. If content overflows, starts continuous scrolling animation
/// 4. Scrolls content from start to end position
/// 5. Pauses briefly (delayDuration) before restarting
/// 6. Applies edge fade effects for smooth visual transitions
///
/// The widget automatically handles text direction (RTL/LTR) and adapts
/// scroll behavior accordingly for proper internationalization support.
///
/// Example:
/// ```dart
/// OverflowMarquee(
///   direction: Axis.horizontal,
///   duration: Duration(seconds: 8),
///   delayDuration: Duration(seconds: 2),
///   fadePortion: 0.15,
///   child: Text(
///     'This is a very long text that will scroll horizontally when it overflows the container',
///     style: TextStyle(fontSize: 16),
///   ),
/// )
/// ```
class OverflowMarquee extends StatefulWidget {
  /// The child widget to display and potentially scroll.
  final Widget child;

  /// Scroll direction (horizontal or vertical).
  ///
  /// If `null`, uses theme default or [Axis.horizontal].
  final Axis? direction;

  /// Total duration for one complete scroll cycle.
  ///
  /// If `null`, uses theme default.
  final Duration? duration;

  /// Distance to scroll per animation step.
  ///
  /// If `null`, scrolls the entire overflow amount.
  final double? step;

  /// Pause duration between scroll cycles.
  ///
  /// If `null`, uses theme default.
  final Duration? delayDuration;

  /// Portion of edges to apply fade effect (0.0 to 1.0).
  ///
  /// For example, 0.15 fades 15% of each edge. If `null`, uses theme default.
  final double? fadePortion;

  /// Animation curve for scroll motion.
  ///
  /// If `null`, uses theme default or [Curves.linear].
  final Curve? curve;

  /// Creates an [OverflowMarquee] widget with customizable scrolling behavior.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Content to display and potentially scroll
  /// - [direction] (Axis?, optional): Scroll direction, defaults to horizontal
  /// - [duration] (Duration?, optional): Time for one complete scroll cycle
  /// - [delayDuration] (Duration?, optional): Pause time before restarting animation
  /// - [step] (double?, optional): Step size for scroll speed calculation
  /// - [fadePortion] (double?, optional): Fade effect intensity at edges (0.0-1.0)
  /// - [curve] (Curve?, optional): Animation easing curve
  ///
  /// All optional parameters will use theme defaults or built-in fallback values
  /// when not explicitly provided.
  ///
  /// Example:
  /// ```dart
  /// OverflowMarquee(
  ///   duration: Duration(seconds: 10),
  ///   delayDuration: Duration(seconds: 1),
  ///   fadePortion: 0.2,
  ///   child: Text('Long scrolling text content'),
  /// )
  /// ```
  const OverflowMarquee({
    super.key,
    required this.child,
    this.direction,
    this.duration,
    this.delayDuration,
    this.step,
    this.fadePortion,
    this.curve,
  });

  @override
  State<OverflowMarquee> createState() => _OverflowMarqueeState();
}

class _OverflowMarqueeState extends State<OverflowMarquee>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  Duration elapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      if (mounted) {
        setState(() {
          this.elapsed = elapsed;
        });
      }
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);
    final compTheme = ComponentTheme.maybeOf<OverflowMarqueeTheme>(context);
    final direction = styleValue(
        widgetValue: widget.direction,
        themeValue: compTheme?.direction,
        defaultValue: Axis.horizontal);
    final fadePortion = styleValue(
        widgetValue: widget.fadePortion,
        themeValue: compTheme?.fadePortion,
        defaultValue: 25.0);
    final duration = styleValue(
        widgetValue: widget.duration,
        themeValue: compTheme?.duration,
        defaultValue: const Duration(seconds: 1));
    final delayDuration = styleValue(
        widgetValue: widget.delayDuration,
        themeValue: compTheme?.delayDuration,
        defaultValue: const Duration(milliseconds: 500));
    final step = styleValue(
        widgetValue: widget.step,
        themeValue: compTheme?.step,
        defaultValue: 100.0);
    final curve = widget.curve ?? compTheme?.curve ?? Curves.linear;
    return ClipRect(
      child: _OverflowMarqueeLayout(
        direction: direction,
        fadePortion: fadePortion,
        duration: duration,
        delayDuration: delayDuration,
        ticker: _ticker,
        elapsed: elapsed,
        step: step,
        textDirection: textDirection,
        curve: curve,
        child: widget.child,
      ),
    );
  }
}

class _OverflowMarqueeLayout extends SingleChildRenderObjectWidget {
  final Axis direction;
  final double fadePortion;
  final Duration duration;
  final Duration delayDuration;
  final Ticker ticker;
  final Duration elapsed;
  final double step;
  final TextDirection textDirection;
  final Curve curve;

  const _OverflowMarqueeLayout({
    required this.direction,
    this.fadePortion = 25,
    required this.duration,
    required this.delayDuration,
    required this.ticker,
    required this.elapsed,
    required this.step,
    required this.textDirection,
    required this.curve,
    required Widget child,
  }) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderOverflowMarqueeLayout(
      direction: direction,
      fadePortion: fadePortion,
      duration: duration,
      delayDuration: delayDuration,
      ticker: ticker,
      step: step,
      elapsed: elapsed,
      textDirection: textDirection,
      curve: curve,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderOverflowMarqueeLayout renderObject) {
    bool hasChanged = false;
    if (renderObject.direction != direction) {
      renderObject.direction = direction;
      hasChanged = true;
    }
    if (renderObject.fadePortion != fadePortion) {
      renderObject.fadePortion = fadePortion;
      hasChanged = true;
    }
    if (renderObject.duration != duration) {
      renderObject.duration = duration;
      hasChanged = true;
    }
    if (renderObject.delayDuration != delayDuration) {
      renderObject.delayDuration = delayDuration;
      hasChanged = true;
    }
    // most likely this will never change
    if (renderObject.ticker != ticker) {
      renderObject.ticker = ticker;
      hasChanged = true;
    }
    if (renderObject.elapsed != elapsed) {
      renderObject.elapsed = elapsed;
      hasChanged = true;
    }
    if (renderObject.step != step) {
      renderObject.step = step;
      hasChanged = true;
    }
    if (renderObject.textDirection != textDirection) {
      renderObject.textDirection = textDirection;
      hasChanged = true;
    }
    if (renderObject.curve != curve) {
      renderObject.curve = curve;
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
  Axis direction;
  double fadePortion;
  Duration duration;
  Duration delayDuration;
  Ticker ticker;
  Duration elapsed;
  double step;
  TextDirection textDirection;
  Curve curve;

  _RenderOverflowMarqueeLayout({
    required this.direction,
    required this.fadePortion,
    required this.duration,
    required this.delayDuration,
    required this.ticker,
    required this.elapsed,
    required this.step,
    required this.textDirection,
    required this.curve,
  }) : super(null);

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _OverflowMarqueeParentData) {
      child.parentData = _OverflowMarqueeParentData();
    }
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (direction == Axis.horizontal) {
      return super.computeMaxIntrinsicHeight(double.infinity);
    }
    return super.computeMaxIntrinsicHeight(width);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    if (direction == Axis.vertical) {
      return super.computeMaxIntrinsicWidth(double.infinity);
    }
    return super.computeMaxIntrinsicWidth(height);
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    if (direction == Axis.horizontal) {
      return super.computeMinIntrinsicHeight(double.infinity);
    }
    return super.computeMinIntrinsicHeight(width);
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    if (direction == Axis.vertical) {
      return super.computeMinIntrinsicWidth(double.infinity);
    }
    return super.computeMinIntrinsicWidth(height);
  }

  @override
  Size computeDryLayout(covariant BoxConstraints constraints) {
    if (direction == Axis.horizontal) {
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
    double durationInMicros =
        duration.inMicroseconds * ((sizeDiff ?? 0) / step);
    int delayDurationInMicros = delayDuration.inMicroseconds;
    double elapsedInMicros = elapsed.inMicroseconds.toDouble();
    // includes the reverse
    double overalCycleDuration = delayDurationInMicros +
        durationInMicros +
        delayDurationInMicros +
        durationInMicros;
    elapsedInMicros = elapsedInMicros % overalCycleDuration;
    bool reverse = elapsedInMicros > delayDurationInMicros + durationInMicros;
    double cycleElapsedInMicros =
        elapsedInMicros % (delayDurationInMicros + durationInMicros);
    if (cycleElapsedInMicros < delayDurationInMicros) {
      return reverse ? 1 : 0;
    } else if (cycleElapsedInMicros <
        delayDurationInMicros + durationInMicros) {
      double progress =
          (cycleElapsedInMicros - delayDurationInMicros) / durationInMicros;
      progress = curve.transform(progress);
      return reverse ? 1 - progress : progress;
    } else {
      return reverse ? 0 : 1;
    }
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
      return (progressedSize / fadePortion).clamp(0, 1);
    }
    return 0;
  }

  double get fadeEndProgress {
    final child = this.child;
    if (child != null) {
      double size = sizeDiff ?? 0;
      double progressedSize = size * (1 - offsetProgress);
      return (progressedSize / fadePortion).clamp(0, 1);
    }
    return 0;
  }

  Shader _createAlphaShader(
      bool fadeStart, bool fadeEnd, Rect bounds, double fadePortion) {
    double portionSize;
    if (direction == Axis.horizontal) {
      portionSize = fadePortion / bounds.width;
    } else {
      portionSize = fadePortion / bounds.height;
    }
    List<Color> colors = [];
    List<double> stops = [];
    if (fadeStart) {
      double start = fadeStartProgress;
      Color startColor = Colors.white.withValues(alpha: 1 - start);
      colors.addAll([startColor, Colors.white]);
      stops.addAll([0.0, portionSize]);
    } else {
      colors.addAll([Colors.white]);
      stops.addAll([0.0]);
    }
    if (fadeEnd) {
      double end = fadeEndProgress;
      Color endColor = Colors.white.withValues(alpha: 1 - end);
      colors.addAll([Colors.white, endColor]);
      stops.addAll([1.0 - portionSize, 1.0]);
    } else {
      colors.addAll([Colors.white]);
      stops.addAll([1.0]);
    }
    AlignmentGeometry begin;
    AlignmentGeometry end;
    if (direction == Axis.horizontal) {
      begin = AlignmentDirectional.centerStart.resolve(textDirection);
      end = AlignmentDirectional.centerEnd.resolve(textDirection);
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
    var child = this.child;
    if (child != null) {
      layer ??= ShaderMaskLayer();
      final parentData = child.parentData as _OverflowMarqueeParentData;
      final sizeDiff = parentData.sizeDiff ?? 0;
      var progress = offsetProgress;
      Shader shader = _createAlphaShader(
        progress > 0 && sizeDiff != 0,
        progress < 1 && sizeDiff != 0,
        (Offset.zero & size),
        25,
      );
      assert(needsCompositing);
      layer!
        ..shader = shader
        ..maskRect = (offset & size).inflate(1)
        ..blendMode = BlendMode.modulate;
      context.pushLayer(layer!, _paintChild, offset);
      assert(() {
        layer!.debugCreator = debugCreator;
        return true;
      }());
    } else {
      layer = null;
    }
  }

  void _paintChild(PaintingContext context, Offset offset) {
    final child = this.child;
    if (child != null) {
      final parentData = child.parentData as _OverflowMarqueeParentData;
      context.paintChild(child, offset + parentData.offset);
    }
  }

  @override
  void performLayout() {
    var child = this.child;
    if (child != null) {
      var constraints = this.constraints;
      if (direction == Axis.horizontal) {
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
      if (sizeDiff > 0 && size.width > 0 && size.height > 0) {
        if (!ticker.isActive) {
          ticker.start();
        }
      } else {
        if (ticker.isActive) {
          ticker.stop();
        }
      }
      var progress = offsetProgress;
      final offset = direction == Axis.horizontal
          ? Offset(-sizeDiff * progress, 0)
          : Offset(0, -sizeDiff * progress);
      final parentData = child.parentData as _OverflowMarqueeParentData;
      parentData.sizeDiff = sizeDiff;
      parentData.offset = offset;
    } else {
      size = constraints.biggest;
      if (ticker.isActive) {
        ticker.stop();
      }
    }
  }
}
