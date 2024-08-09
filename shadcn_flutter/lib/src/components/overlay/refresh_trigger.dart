import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class RefreshTrigger extends StatefulWidget {
  final double minExtent;
  final double? maxExtent;
  final VoidCallback? onRefresh;
  final Widget child;
  final Axis direction;
  final bool reverse;

  const RefreshTrigger({
    Key? key,
    this.minExtent = 100.0,
    this.maxExtent = 200.0,
    this.onRefresh,
    this.direction = Axis.vertical,
    this.reverse = false,
    required this.child,
  }) : super(key: key);

  @override
  State<RefreshTrigger> createState() => _RefreshTriggerState();
}

class _RefreshTriggerState extends State<RefreshTrigger> {
  double _currentExtent = 0.0;

  Widget _wrapPadding(BuildContext context, double extent) {
    return Padding(
      padding: widget.direction == Axis.vertical
          ? EdgeInsets.only(
              top: widget.reverse ? extent : 0,
              bottom: widget.reverse ? 0 : extent,
            )
          : EdgeInsets.only(
              left: widget.reverse ? extent : 0,
              right: widget.reverse ? 0 : extent,
            ),
      child: widget.child,
    );
  }

  double _calculateExtent(double extent) {
    if (widget.maxExtent != null) {
      return extent.clamp(widget.minExtent, widget.maxExtent!);
    }
    return extent;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          setState(() {
            _currentExtent += notification.scrollDelta!;
            if (_currentExtent >= widget.minExtent) {
              widget.onRefresh?.call();
            }
          });
        }
        return false;
      },
      child: widget.child,
    );
  }
}
