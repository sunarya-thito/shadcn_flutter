import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme configuration for hover-based components and interactions.
///
/// [HoverTheme] defines timing and behavior parameters for hover-sensitive widgets
/// such as tooltips, dropdowns, and other overlay components that respond to mouse
/// hover events. This theme provides fine-grained control over hover timing to
/// create smooth, responsive interactions.
///
/// The hover system supports configurable delays, minimum durations, and hit-test
/// behaviors to optimize user experience across different interaction patterns.
/// These settings can be applied globally through the theme system or per-component
/// as needed.
///
/// Example:
/// ```dart
/// ComponentTheme<HoverTheme>(
///   data: HoverTheme(
///     waitDuration: Duration(milliseconds: 800),
///     showDuration: Duration(milliseconds: 200),
///     debounceDuration: Duration(milliseconds: 100),
///   ),
///   child: MyHoverWidget(),
/// )
/// ```
class HoverTheme {
  /// Debounce duration for rapid hover state changes.
  ///
  /// Controls the delay before processing hover state transitions when the mouse
  /// rapidly enters and exits the hover area. This prevents flickering and
  /// improves performance during fast mouse movements.
  ///
  /// When null, uses the framework default debounce timing.
  final Duration? debounceDuration;

  /// Hit test behavior for hover detection areas.
  ///
  /// Determines how the hover region responds to hit testing:
  /// - [HitTestBehavior.opaque]: Absorbs all hits within bounds
  /// - [HitTestBehavior.translucent]: Receives hits but allows pass-through
  /// - [HitTestBehavior.deferToChild]: Only hits if child widgets are hit
  ///
  /// When null, uses the framework default behavior.
  final HitTestBehavior? hitTestBehavior;

  /// Duration to wait before showing hover effects.
  ///
  /// The delay between mouse entering the hover area and hover effects becoming
  /// visible. This prevents accidental hover activation during normal cursor
  /// movement and improves perceived performance.
  ///
  /// Common values: 500-1000ms for tooltips, 200-400ms for button states.
  /// When null, uses the framework default wait duration.
  final Duration? waitDuration;

  /// Minimum duration to keep hover effects visible once shown.
  ///
  /// Ensures hover effects remain visible for at least this duration, preventing
  /// rapid flickering when the mouse briefly leaves and re-enters the hover area.
  /// This creates more stable interactions, especially for touch interfaces.
  ///
  /// When null, uses the framework default minimum duration.
  final Duration? minDuration;

  /// Duration for hover effect entrance animations.
  ///
  /// Controls the timing of animations when hover effects appear, such as
  /// tooltip fade-in, button state transitions, or overlay presentations.
  /// This affects the perceived responsiveness of hover interactions.
  ///
  /// When null, uses the framework default show animation duration.
  final Duration? showDuration;

  /// Creates a [HoverTheme] with optional timing and behavior configuration.
  ///
  /// All parameters are optional and fall back to framework defaults when null.
  /// Combine these parameters to create hover behaviors appropriate for different
  /// types of interactions and UI components.
  ///
  /// Parameters:
  /// - [debounceDuration]: Delay for processing rapid hover changes
  /// - [hitTestBehavior]: How hover areas respond to hit testing  
  /// - [waitDuration]: Delay before showing hover effects
  /// - [minDuration]: Minimum time to keep effects visible
  /// - [showDuration]: Duration of entrance animations
  const HoverTheme({
    this.debounceDuration,
    this.hitTestBehavior,
    this.waitDuration,
    this.minDuration,
    this.showDuration,
  });

  HoverTheme copyWith({
    ValueGetter<Duration?>? debounceDuration,
    ValueGetter<HitTestBehavior?>? hitTestBehavior,
    ValueGetter<Duration?>? waitDuration,
    ValueGetter<Duration?>? minDuration,
    ValueGetter<Duration?>? showDuration,
  }) {
    return HoverTheme(
      debounceDuration:
          debounceDuration == null ? this.debounceDuration : debounceDuration(),
      hitTestBehavior: hitTestBehavior == null
          ? this.hitTestBehavior
          : hitTestBehavior(),
      waitDuration:
          waitDuration == null ? this.waitDuration : waitDuration(),
      minDuration: minDuration == null ? this.minDuration : minDuration(),
      showDuration: showDuration == null ? this.showDuration : showDuration(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HoverTheme &&
        other.debounceDuration == debounceDuration &&
        other.hitTestBehavior == hitTestBehavior &&
        other.waitDuration == waitDuration &&
        other.minDuration == minDuration &&
        other.showDuration == showDuration;
  }

  @override
  int get hashCode => Object.hash(
        debounceDuration,
        hitTestBehavior,
        waitDuration,
        minDuration,
        showDuration,
      );
}

/// Widget that tracks mouse cursor hover state with debounced event handling.
///
/// [HoverActivity] monitors when the mouse cursor hovers over its child widget
/// and triggers callbacks at configurable intervals. It provides debounced hover
/// event handling to prevent excessive callback firing during normal mouse movement.
///
/// This widget is useful for implementing hover-based features like:
/// - Periodic updates during hover (e.g., live previews)
/// - Hover analytics or tracking
/// - Custom hover effects that need regular updates
/// - Performance monitoring during hover interactions
///
/// The widget uses an internal animation controller to manage the debounce timing,
/// ensuring smooth and predictable hover event delivery.
///
/// Example:
/// ```dart
/// HoverActivity(
///   debounceDuration: Duration(milliseconds: 200),
///   onEnter: () => print('Mouse entered'),
///   onHover: () => print('Mouse hovering...'),
///   onExit: () => print('Mouse exited'),
///   child: Container(
///     width: 200,
///     height: 100,
///     color: Colors.blue,
///     child: Text('Hover over me'),
///   ),
/// )
/// ```
class HoverActivity extends StatefulWidget {
  /// The child widget to monitor for hover events.
  ///
  /// This widget will be the active hover area. Mouse movements over this
  /// widget and its descendants will trigger the hover callbacks.
  final Widget child;

  /// Callback invoked periodically while the mouse hovers.
  ///
  /// Called at intervals defined by [debounceDuration] while the cursor
  /// remains within the hover area. Use this for actions that need regular
  /// updates during hover, such as live previews or progress indicators.
  final VoidCallback? onHover;

  /// Callback invoked when the mouse cursor exits the hover area.
  ///
  /// Called once when the cursor leaves the widget boundaries or when
  /// the widget is disposed while hovered. Use this to clean up hover
  /// effects or reset hover-related state.
  final VoidCallback? onExit;

  /// Callback invoked when the mouse cursor enters the hover area.
  ///
  /// Called once when the cursor first enters the widget boundaries.
  /// Use this to initialize hover effects or start hover-related processes.
  final VoidCallback? onEnter;

  /// Duration between [onHover] callback invocations.
  ///
  /// Controls how frequently the [onHover] callback is triggered while
  /// the mouse remains in the hover area. Longer durations reduce callback
  /// frequency but may feel less responsive. Shorter durations provide
  /// smoother updates but may impact performance.
  ///
  /// When null, uses the theme's debounce duration or a reasonable default.
  final Duration? debounceDuration;

  /// Hit test behavior for the hover detection area.
  ///
  /// Determines how the widget responds to hit testing:
  /// - [HitTestBehavior.opaque]: Blocks hits to widgets below
  /// - [HitTestBehavior.translucent]: Allows hits to pass through  
  /// - [HitTestBehavior.deferToChild]: Only registers hits on child widgets
  ///
  /// When null, uses the theme's hit test behavior or a reasonable default.
  final HitTestBehavior? hitTestBehavior;

  /// Creates a [HoverActivity] widget with hover event monitoring.
  ///
  /// Parameters:
  /// - [child] (Widget, required): The widget to monitor for hover events
  /// - [onHover] (VoidCallback?, optional): Periodic callback during hover
  /// - [onExit] (VoidCallback?, optional): Callback when cursor exits
  /// - [onEnter] (VoidCallback?, optional): Callback when cursor enters
  /// - [debounceDuration] (Duration?, optional): Time between hover callbacks
  /// - [hitTestBehavior] (HitTestBehavior?, optional): Hit testing behavior
  const HoverActivity({
    super.key,
    required this.child,
    this.onHover,
    this.onExit,
    this.onEnter,
    this.hitTestBehavior,
    this.debounceDuration,
  });

  @override
  State<HoverActivity> createState() => _HoverActivityState();
}

class _HoverActivityState extends State<HoverActivity>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.debounceDuration,
    );
    _controller.addStatusListener(_onStatusChanged);
  }

  void _onStatusChanged(AnimationStatus status) {
    widget.onHover?.call();
  }

  @override
  void didUpdateWidget(covariant HoverActivity oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = widget.debounceDuration;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<HoverTheme>(context);
    final debounceDuration = styleValue(
        widgetValue: widget.debounceDuration,
        themeValue: compTheme?.debounceDuration,
        defaultValue: const Duration(milliseconds: 100));
    final behavior = styleValue(
        widgetValue: widget.hitTestBehavior,
        themeValue: compTheme?.hitTestBehavior,
        defaultValue: HitTestBehavior.deferToChild);
    _controller.duration = debounceDuration;
    return MouseRegion(
      hitTestBehavior: behavior,
      onEnter: (_) {
        widget.onEnter?.call();
        _controller.repeat(reverse: true);
      },
      onExit: (_) {
        _controller.stop();
        widget.onExit?.call();
      },
      child: widget.child,
    );
  }
}

class Hover extends StatefulWidget {
  final Widget child;
  final void Function(bool hovered) onHover;
  final Duration? waitDuration;
  final Duration?
      minDuration; // The minimum duration to show the hover, if the cursor is quickly moved over the widget.
  final Duration? showDuration; // The duration to show the hover
  final HitTestBehavior? hitTestBehavior;

  const Hover({
    super.key,
    required this.child,
    required this.onHover,
    this.waitDuration,
    this.minDuration,
    this.showDuration,
    this.hitTestBehavior,
  });

  @override
  _HoverState createState() => _HoverState();
}

class _HoverState extends State<Hover> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int? _enterTime;
  late Duration _waitDur;
  late Duration _minDur;
  late Duration _showDur;
  late HitTestBehavior _behavior;

  @override
  void initState() {
    super.initState();
    _waitDur = widget.waitDuration ?? const Duration(milliseconds: 500);
    _minDur = widget.minDuration ?? const Duration(milliseconds: 0);
    _showDur = widget.showDuration ?? const Duration(milliseconds: 200);
    _controller = AnimationController(
      vsync: this,
      duration: _waitDur,
    );
    _controller.addStatusListener(_onStatusChanged);
  }

  void _onEnter() {
    _enterTime = DateTime.now().millisecondsSinceEpoch;
    _controller.forward();
  }

  void _onExit(bool cursorOut) {
    int minDuration = _minDur.inMilliseconds;
    int? enterTime = _enterTime;
    if (enterTime != null) {
      int duration = DateTime.now().millisecondsSinceEpoch - enterTime;
      _controller.reverseDuration = cursorOut
          ? Duration(milliseconds: duration < minDuration ? minDuration : 0)
          : _showDur;
      _controller.reverse();
    }
    _enterTime = null;
  }

  void _onStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      widget.onHover(true);
    } else if (status == AnimationStatus.dismissed) {
      widget.onHover(false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    final compTheme = ComponentTheme.maybeOf<HoverTheme>(context);
    _waitDur = styleValue(
        widgetValue: widget.waitDuration,
        themeValue: compTheme?.waitDuration,
        defaultValue: const Duration(milliseconds: 500));
    _minDur = styleValue(
        widgetValue: widget.minDuration,
        themeValue: compTheme?.minDuration,
        defaultValue: const Duration(milliseconds: 0));
    _showDur = styleValue(
        widgetValue: widget.showDuration,
        themeValue: compTheme?.showDuration,
        defaultValue: const Duration(milliseconds: 200));
    _behavior = styleValue(
        widgetValue: widget.hitTestBehavior,
        themeValue: compTheme?.hitTestBehavior,
        defaultValue: HitTestBehavior.deferToChild);
    _controller.duration = _waitDur;
    bool enableLongPress = platform == TargetPlatform.iOS ||
        platform == TargetPlatform.android ||
        platform == TargetPlatform.fuchsia;
    return TapRegion(
      behavior: _behavior,
      onTapOutside: (details) {
        _onExit(true);
      },
      child: MouseRegion(
        hitTestBehavior: _behavior,
        onEnter: (_) => _onEnter(),
        onExit: (_) {
          _onExit(true);
        },
        child: GestureDetector(
          // for mobile platforms, hover is triggered by a long press
          onLongPressDown: enableLongPress
              ? (details) {
                  _onEnter();
                }
              : null,
          onLongPressCancel: enableLongPress
              ? () {
                  _onExit(true);
                }
              : null,
          onLongPressUp: enableLongPress
              ? () {
                  _onExit(true);
                }
              : null,
          child: widget.child,
        ),
      ),
    );
  }
}
