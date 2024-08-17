import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef RefreshIndicatorBuilder = Widget Function(
    BuildContext context, RefreshTriggerStage stage);

class RefreshTrigger extends StatefulWidget {
  static Widget defaultIndicatorBuilder(
      BuildContext context, RefreshTriggerStage stage) {
    return DefaultRefreshIndicator(stage: stage);
  }

  final double minExtent;
  final double? maxExtent;
  final VoidCallback? onRefresh;
  final Widget child;
  final Axis direction;
  final bool reverse;
  final RefreshIndicatorBuilder indicatorBuilder;
  final Curve curve;

  const RefreshTrigger({
    Key? key,
    this.minExtent = 100.0,
    this.maxExtent = 200.0,
    this.onRefresh,
    this.direction = Axis.vertical,
    this.reverse = false,
    this.indicatorBuilder = defaultIndicatorBuilder,
    this.curve = Curves.easeInOut,
    required this.child,
  }) : super(key: key);

  @override
  State<RefreshTrigger> createState() => _RefreshTriggerState();
}

class DefaultRefreshIndicator extends StatelessWidget {
  final RefreshTriggerStage stage;

  const DefaultRefreshIndicator({Key? key, required this.stage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class _RefreshTriggerState extends State<RefreshTrigger>
    with SingleTickerProviderStateMixin {
  // double _currentExtent = 0.0;
  late AnimationController _currentExtent;
  bool _scrolling = false;
  ScrollableState? _scrollable;

  @override
  void initState() {
    super.initState();
    _currentExtent = AnimationController(
      vsync: this,
    );
  }

  double _calculateSafeExtent(double extent) {
    if (widget.maxExtent != null) {
      return extent.min(widget.maxExtent!);
    }
    return extent;
  }

  Offset get _translate {
    switch (widget.direction) {
      case Axis.horizontal:
        return Offset(_calculateSafeExtent(_currentExtent.value), 0);
      case Axis.vertical:
        return Offset(0, _calculateSafeExtent(_currentExtent.value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollStartNotification &&
            notification.depth == 0) {
          var context = notification.context;
          if (context != null) {
            // hold the scroll position
            ScrollableState? scrollable =
                Scrollable.maybeOf(context, axis: widget.direction);
            if (scrollable != null) {
              setState(() {
                _currentExtent.value = 0.0;
                _scrolling = true;
                _scrollable = scrollable;
              });
            }
          }

          return true;
        }
        if (notification is ScrollEndNotification && notification.depth == 0) {
          setState(() {
            _scrolling = false;
            _currentExtent.value = 0.0;
            _scrollable = null;
          });
          return true;
        }
        if (notification is OverscrollNotification &&
            notification.depth == 0 &&
            notification.overscroll < 0) {
          if (notification.metrics.axis == widget.direction) {
            setState(() {
              _currentExtent.value -= notification.overscroll;
            });
          }
          return true;
        }
        if (notification is ScrollUpdateNotification &&
            notification.depth == 0 &&
            (notification.scrollDelta ?? 0) > 0 &&
            _scrollable != null) {
          if (notification.metrics.axis == widget.direction) {
            setState(() {
              _currentExtent.value = 0.0;
              _scrolling = false;
              _scrollable = null;
            });
            return true;
          }
        }
        return false;
      },
      child: GestureDetector(
        onPanStart: (details) {
          print('onPanStart');
        },
        onPanUpdate: (details) {
          print('onPanUpdate');
        },
        onPanEnd: (details) {
          print('onPanEnd');
        },
        onPanCancel: () {
          print('onPanCancel');
        },
        child: AnimatedValueBuilder(
          value: _translate,
          duration: _scrolling ? Duration.zero : kDefaultDuration,
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Transform.translate(
              offset: value,
              child: child,
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}

enum TriggerStage {
  idle,
  pulling,
  refreshing,
  completed,
}

class RefreshTriggerStage {
  final TriggerStage stage;
  final Animation<double> extent;

  const RefreshTriggerStage(this.stage, this.extent);
}
