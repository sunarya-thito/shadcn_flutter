import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A widget that tracks the hover state of the mouse cursor
/// and will call the [onHover] with period of [debounceDuration] when the cursor is hovering over the child widget.
class HoverActivity extends StatefulWidget {
  final Widget child;
  final VoidCallback? onHover;
  final VoidCallback? onExit;
  final VoidCallback? onEnter;
  final Duration debounceDuration;
  final HitTestBehavior hitTestBehavior;

  const HoverActivity({
    Key? key,
    required this.child,
    this.onHover,
    this.onExit,
    this.onEnter,
    this.hitTestBehavior = HitTestBehavior.deferToChild,
    this.debounceDuration = const Duration(milliseconds: 100),
  }) : super(key: key);

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
    return MouseRegion(
      hitTestBehavior: widget.hitTestBehavior,
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
  final Duration waitDuration;
  final Duration
      minDuration; // The minimum duration to show the hover, if the cursor is quickly moved over the widget.
  final Duration showDuration; // The duration to show the hover
  final HitTestBehavior hitTestBehavior;

  const Hover({
    Key? key,
    required this.child,
    required this.onHover,
    this.waitDuration = const Duration(milliseconds: 500),
    this.minDuration = const Duration(milliseconds: 0),
    this.showDuration = const Duration(milliseconds: 200),
    this.hitTestBehavior = HitTestBehavior.deferToChild,
  }) : super(key: key);

  @override
  _HoverState createState() => _HoverState();
}

class _HoverState extends State<Hover> with SingleTickerProviderStateMixin {
  bool _longPress = false;
  late AnimationController _controller;
  int? _enterTime;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.waitDuration,
    );
    _controller.addStatusListener(_onStatusChanged);
  }

  void _onEnter() {
    _enterTime = DateTime.now().millisecondsSinceEpoch;
    _controller.forward();
  }

  void _onExit(bool cursorOut) {
    int minDuration = widget.minDuration.inMilliseconds;
    int? enterTime = _enterTime;
    if (enterTime != null) {
      int duration = DateTime.now().millisecondsSinceEpoch - enterTime;
      _controller.reverseDuration = cursorOut
          ? Duration(milliseconds: duration < minDuration ? minDuration : 0)
          : widget.showDuration;
      _controller.reverse();
    }
    _longPress = false;
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
    bool enableLongPress = platform == TargetPlatform.iOS ||
        platform == TargetPlatform.android ||
        platform == TargetPlatform.fuchsia;
    return TapRegion(
      onTapOutside: (details) {
        _onExit(true);
      },
      child: MouseRegion(
        onEnter: (_) => _onEnter(),
        onExit: (_) {
          _onExit(true);
        },
        child: GestureDetector(
          // for mobile platforms, hover is triggered by a long press
          onLongPressDown: enableLongPress
              ? (details) {
                  _longPress = true;
                  _onEnter();
                }
              : null,
          child: widget.child,
        ),
      ),
    );
  }
}
