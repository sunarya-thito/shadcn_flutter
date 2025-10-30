import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme configuration for hover-related widgets and behaviors.
///
/// [HoverTheme] provides configurable durations and behaviors for hover
/// interactions throughout the application. It can be registered in the
/// component theme system to customize hover behavior globally.
///
/// Example:
/// ```dart
/// HoverTheme(
///   debounceDuration: Duration(milliseconds: 100),
///   hitTestBehavior: HitTestBehavior.opaque,
/// )
/// ```
class HoverTheme {
  /// Debounce duration for repeated hover events.
  ///
  /// When set, hover callbacks are throttled to fire at most once per this duration.
  final Duration? debounceDuration;

  /// Hit test behavior for hover detection.
  ///
  /// Determines how the widget participates in hit testing for mouse events.
  final HitTestBehavior? hitTestBehavior;

  /// Wait duration before showing hover feedback (e.g., tooltips).
  ///
  /// Delays the appearance of hover-triggered UI to avoid flashing on quick passes.
  final Duration? waitDuration;

  /// Minimum duration to keep hover feedback visible once shown.
  ///
  /// Prevents hover UI from disappearing too quickly.
  final Duration? minDuration;

  /// Duration for hover feedback show animations.
  final Duration? showDuration;

  /// Creates a [HoverTheme] with optional configuration values.
  const HoverTheme({
    this.debounceDuration,
    this.hitTestBehavior,
    this.waitDuration,
    this.minDuration,
    this.showDuration,
  });

  /// Creates a copy of this theme with selectively replaced properties.
  ///
  /// Parameters are [ValueGetter] functions to allow setting values to `null`.
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
      hitTestBehavior:
          hitTestBehavior == null ? this.hitTestBehavior : hitTestBehavior(),
      waitDuration: waitDuration == null ? this.waitDuration : waitDuration(),
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

/// A widget that tracks mouse hover state and triggers callbacks.
///
/// [HoverActivity] monitors when the mouse cursor enters, hovers over, and exits
/// its child widget, calling appropriate callbacks. The [onHover] callback can be
/// called repeatedly while hovering if [debounceDuration] is set.
///
/// Example:
/// ```dart
/// HoverActivity(
///   debounceDuration: Duration(milliseconds: 500),
///   onEnter: () => print('Mouse entered'),
///   onHover: () => print('Still hovering'),
///   onExit: () => print('Mouse exited'),
///   child: Container(
///     width: 100,
///     height: 100,
///     color: Colors.blue,
///   ),
/// )
/// ```
class HoverActivity extends StatefulWidget {
  /// The widget to track for hover events.
  final Widget child;

  /// Called periodically while hovering, at intervals of [debounceDuration].
  ///
  /// If [debounceDuration] is `null`, this is called only once on initial hover.
  final VoidCallback? onHover;

  /// Called when the mouse cursor exits the widget bounds.
  final VoidCallback? onExit;

  /// Called when the mouse cursor first enters the widget bounds.
  final VoidCallback? onEnter;

  /// Interval for repeated [onHover] callbacks while the cursor remains over the widget.
  ///
  /// If `null`, [onHover] is called only once when hover begins.
  final Duration? debounceDuration;

  /// Hit test behavior determining how this widget participates in pointer event handling.
  final HitTestBehavior? hitTestBehavior;

  /// Creates a [HoverActivity] widget.
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

/// A widget that manages hover state with configurable timing behavior.
///
/// [Hover] provides sophisticated hover detection with delays and minimum durations
/// to prevent flickering when the cursor quickly passes over the widget. It calls
/// [onHover] with `true` when hover activates and `false` when it deactivates.
///
/// Unlike [HoverActivity], this widget implements smart timing:
/// - [waitDuration]: Delay before activating hover
/// - [minDuration]: Minimum time to keep hover active once triggered
/// - [showDuration]: Total duration for hover state
///
/// Example:
/// ```dart
/// Hover(
///   waitDuration: Duration(milliseconds: 500),
///   minDuration: Duration(milliseconds: 200),
///   onHover: (hovered) {
///     print(hovered ? 'Hover activated' : 'Hover deactivated');
///   },
///   child: Container(
///     width: 100,
///     height: 100,
///     color: Colors.blue,
///   ),
/// )
/// ```
class Hover extends StatefulWidget {
  /// The widget to track for hover events.
  final Widget child;

  /// Called with `true` when hover activates, `false` when it deactivates.
  ///
  /// Activation respects [waitDuration] delay, and deactivation respects [minDuration].
  final void Function(bool hovered) onHover;

  /// Delay before activating hover after cursor enters.
  ///
  /// Prevents accidental activation from quick cursor passes. Defaults to 500ms.
  final Duration? waitDuration;

  /// Minimum duration to keep hover active once triggered.
  ///
  /// Prevents flickering when cursor quickly moves over the widget. Defaults to 0ms.
  final Duration?
      minDuration; // The minimum duration to show the hover, if the cursor is quickly moved over the widget.

  /// Total duration for hover state before auto-deactivation.
  final Duration? showDuration; // The duration to show the hover

  /// Hit test behavior for pointer event handling.
  final HitTestBehavior? hitTestBehavior;

  /// Creates a [Hover] widget with timing configuration.
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
  State<Hover> createState() => _HoverState();
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
