import 'package:flutter/material.dart';

class Hover extends StatefulWidget {
  final Widget child;
  final void Function(bool hovered) onHover;
  final Duration waitDuration;
  final Duration
      minDuration; // The minimum duration to show the hover, if the cursor is quickly moved over the widget.
  final Duration showDuration; // The duration to show the hover

  const Hover({
    Key? key,
    required this.child,
    required this.onHover,
    this.waitDuration = const Duration(milliseconds: 500),
    this.minDuration = const Duration(milliseconds: 0),
    this.showDuration = const Duration(milliseconds: 200),
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
      if (_longPress) {
        _onExit(false);
      }
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
    return MouseRegion(
      onEnter: (_) => _onEnter(),
      onExit: (_) => _onExit(true),
      child: GestureDetector(
        // for mobile platforms, hover is triggered by a long press
        onLongPress: () {
          _longPress = true;
          _onEnter();
        },
        child: widget.child,
      ),
    );
  }
}
